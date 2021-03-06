#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use feature 'say';
use Data::Dump 'dump';
use Getopt::Long;
use HTTP::Request;
use IMicrobe::DB;
use MongoDB;
use JSON::XS;
use LWP::UserAgent;
use Pod::Usage;
use Readonly;
use String::Trim qw(trim);

Readonly my %INDEX_FLDS => (
    centrifuge      => [qw(name tax_id)],
    assembly        => [qw(assembly_code assembly_name organism)],
    investigator    => [qw(investigator_name institution)],
    project         => [qw(project_code project_name institution description)],
    project_page    => [qw(title contents)],
    project_group   => [qw(group_name description)],
    publication     => [qw(journal pub_code author title pubmed_id doi)],
    #pfam_annotation => [qw(accession identifier name description)],
    #kegg_annotation => [qw(name definition pathway module)],
    sample          => [qw(sample_acc sample_name sample_type 
        sample_description )],
    combined_assembly => [qw( 
        assembly_name phylum class family genus species strain
    )],
);

Readonly my %NAME_FLD => (
    assembly          => 'assembly_name',
    centrifuge        => 'name',
    investigator      => 'investigator_name',
    #kegg_annotation   => 'name',
    #pfam_annotation   => 'identifier',
    project           => 'project_name',
    project_page      => 'title',
    project_group     => 'group_name',
    publication       => 'title',
    sample            => 'sample_name',
    combined_assembly => 'assembly_name'
);

Readonly my %MONGO_SQL => {
    sample => [
#        q'select "specimen__domain" as name, d.domain_name as value
#          from   sample s, sample_to_domain s2d, domain d
#          where  s.sample_id=?
#          and    s.sample_id=s2d.sample_id
#          and    s2d.domain_id=d.domain_id
#        ',
        q'select "specimen__sample_id" as name, sample_id as value
          from   sample
          where  sample_id=?
        ',
        q'select "specimen__file" as name, file as value
          from   sample_file
          where  sample_id=?
        ',
        q'select "specimen__project_id" as name, project_id as value
          from   sample
          where  sample_id=?
        ',
        q'select "specimen__project_name" as name, p.project_name as value
          from   sample s, project p
          where  s.sample_id=?
          and    s.project_id=p.project_id
        ',
        q'select "specimen__domain_of_life" as name, d.domain_name as value
          from   sample s, project p, project_to_domain p2d, domain d
          where  s.sample_id=?
          and    s.project_id=p.project_id
          and    p.project_id=p2d.project_id
          and    p2d.domain_id=d.domain_id
        ',
        q'select "ontology__ontology_acc" as name, o.ontology_acc as value
          from   ontology o, sample_to_ontology s2o
          where  s2o.sample_id=?
          and    s2o.ontology_id=o.ontology_id
        ',
        q'select "ontology__ontology_label" as name, o.label as value
          from   ontology o, sample_to_ontology s2o
          where  s2o.sample_id=?
          and    s2o.ontology_id=o.ontology_id
        ',
        q'select "publication__pubmed_id" as name, pubmed_id as value
          from   publication p, sample s, project pr
          where  s.sample_id=?
          and    s.project_id=pr.project_id
          and    pr.project_id=p.project_id
        ',
        q'select "publication__title" as name, 
                 concat_ws(" ", p.title, p.author) as value
          from   publication p, sample s, project pr
          where  s.sample_id=?
          and    s.project_id=pr.project_id
          and    pr.project_id=p.project_id
        ',
        q'select concat_ws("__", c.category, t.type) as name, 
          a.attr_value as value
          from   sample_attr a, sample_attr_type t, sample_attr_type_category c
          where  a.sample_id=?
          and    a.sample_attr_type_id=t.sample_attr_type_id
          and    t.sample_attr_type_category_id=c.sample_attr_type_category_id
        ',
#        q'select distinct concat("data__", replace(t.type, ".", "_")) as name, 
#                 "true" as value
#          from   sample_file f, sample_file_type t
#          where  f.sample_file_type_id=t.sample_file_type_id
#          and    f.sample_id=?
#        ',
#        q'select "PFAM_ID" as name, u.identifier as value
#          from   sample_to_uproc s, uproc u
#          where  s.sample_id=?
#          and    s.uproc_id=u.uproc_id
#        ',
#        q'select "KEGG_ID" as name, k.kegg_annotation_id as value
#          from   uproc_kegg_result k
#          where  k.sample_id=?
#        ',
#        q'select "Taxomomy" as name, c.name as value
#          from   centrifuge c, sample_to_centrifuge s
#          where  s.sample_id=?
#          and    s.centrifuge_id=c.centrifuge_id
#        ',
    ],
};

$MongoDB::BSON::looks_like_number = 1;

main();

# --------------------------------------------------
sub main {
    my $tables = '';
    my $list   = '';
    my $db     = 'imicrobe';
    my ($help, $man_page);
    GetOptions(
        'db|d=s'     => \$db,
        'l|list'     => \$list,
        't|tables:s' => \$tables,
        'help'       => \$help,
        'man'        => \$man_page,
    ) or pod2usage(2);

    if ($help || $man_page) {
        pod2usage({
            -exitval => 0,
            -verbose => $man_page ? 2 : 1
        });
    }; 

    if ($list) {
        say join "\n", 
            "Valid tables:",
            (map { " - $_" } sort keys %INDEX_FLDS),
            '',
        ;
        exit 0;
    }

    my %valid  = map { $_, 1 } keys %INDEX_FLDS;
    my @tables = $tables ? split /\s*,\s*/, $tables : keys %valid;
    my @bad    = grep { !$valid{ $_ } } @tables;
    
    if (@bad) {
        die join "\n", "Bad tables:", (map { "  - $_" } @bad), '';
    }

    process($db, sort @tables);
}

# --------------------------------------------------
sub process {
    my $db_name    = shift;
    my @tables     = @_;
    my $db         = IMicrobe::DB->new(name => $db_name);
    my $mongo_conf = IMicrobe::Config->new->get('mongo');
    my $dbh        = $db->dbh;
    my $mongo      = $db->mongo;
    my $mdb_name   = $mongo_conf->{'dbname'};
    my $host       = $mongo_conf->{'host'};
    my $coll_name  = 'sampleKeys';
    my $mdb        = $mongo->get_database($mdb_name);
    $mdb->drop($coll_name);

    for my $table (@tables) {
        my $coll = $mdb->get_collection($table);
        $coll->drop();

        my $name_fld = $NAME_FLD{ $table }      or next;
        my @flds     = @{ $INDEX_FLDS{$table} } or next;
        my $pk_name  = $table . '_id'; 
        unshift @flds, $pk_name;

        my @records = @{$dbh->selectall_arrayref(
            sprintf('select %s from %s', join(', ', @flds), $table), 
            { Columns => {} }
        )};

        printf "Processing %s from table '%s.'\n", scalar(@records), $table;

        $dbh->do('delete from search where table_name=?', {}, $table);

        my @mongo_sql = @{ $MONGO_SQL{ $table } || [] };

        my $i;
        for my $rec (@records) {
            my $pk  = $rec->{ $pk_name } or next;
            my $raw = join(' ', map { trim($rec->{$_} // '') } 
                      grep { $_ ne $pk } @flds);

            my @tmp;
            for my $w (split(/\s+/, $raw)) {
                push @tmp, $w;
                if ($w =~ /[_-]/) {
                    $w =~ s/_/ /g;
                    $w =~ s/-//g;
                    push @tmp, $w;
                }
            }

            my $text = join(' ', @tmp);

            $rec->{'primary_key'} = $pk;

            printf "%-78s\r", ++$i;

            my %mongo_rec = ( sample_name => $rec->{$name_fld} );
            if ($table eq 'sample') {
                for my $sql (@mongo_sql) {
                    my $data =
                      $dbh->selectall_arrayref($sql, { Columns => {} }, $pk);

                    for my $rec (@$data) {
                        my $key = normalize($rec->{'name'}) or next;
                        my $val = trim($rec->{'value'})     or next;
                        if ($mongo_rec{ $key }) {
                            $mongo_rec{ $key } .= " $val";
                        }
                        else {
                            $mongo_rec{ $key } = $val;
                        }
                    }
                }

                $mongo_rec{'text'} = join(' ', 
                    grep { ! /^-?\d+(\.\d+)?$/ }
                    map  { split(/\s+/, $_) }
                    values %mongo_rec
                );

                $coll->insert(\%mongo_rec);
            }

            $dbh->do(
                q[
                    insert
                    into   search 
                           (table_name, primary_key, object_name, search_text)
                    values (?, ?, ?, ?)
                ],
                {},
                ( $table, $pk, substr($rec->{$name_fld}, 0, 254)
                , join(' ', $text, $mongo_rec{'text'} // '')
                )
            );
        }
        print "\n";
    }

    say "Updating Mongo keys";

    `variety $mdb_name/sample --host $host --quiet --outputFormat json | mongoimport --host $host --db $mdb_name --collection $coll_name --jsonArray`;

    say "Done.";
}

# --------------------------------------------------
sub lean_hash {
    my $in = shift;
    my %out;
    while (my ($k, $v) = each %$in) {
        if (defined $v && $v ne '') {
            $out{ $k } = $v;
        }
    }
    return \%out;
}

# --------------------------------------------------
sub normalize {
    my $s   = shift or return;
    my $ret = lc trim($s);
    $ret    =~ s/[\s,-]+/_/g;
    $ret    =~ s/_parameter//;
    $ret    =~ s/[^\w:_]//g;
    return $ret;
}

__END__

# --------------------------------------------------

=pod

=head1 NAME

load-search.pl - a script

=head1 SYNOPSIS

  load-search.pl 

Options:

  -t|--tables  Comma-separated list of tables to index
  --help       Show brief help and exit
  --man        Show full documentation

=head1 DESCRIPTION

Indexes the iMicrobe "search" table.

=head1 AUTHOR

Ken Youens-Clark E<lt>E<gt>.

=head1 COPYRIGHT

Copyright (c) 2015 Ken Youens-Clark

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

=cut
