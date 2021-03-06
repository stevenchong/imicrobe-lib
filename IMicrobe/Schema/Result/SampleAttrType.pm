use utf8;
package IMicrobe::Schema::Result::SampleAttrType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IMicrobe::Schema::Result::SampleAttrType

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<sample_attr_type>

=cut

__PACKAGE__->table("sample_attr_type");

=head1 ACCESSORS

=head2 sample_attr_type_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 sample_attr_type_category_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 url_template

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'mediumtext'
  is_nullable: 1

=head2 units

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 is_numeric

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sample_attr_type_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "sample_attr_type_category_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "type",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "url_template",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "mediumtext", is_nullable => 1 },
  "units",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "is_numeric",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sample_attr_type_id>

=back

=cut

__PACKAGE__->set_primary_key("sample_attr_type_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<type>

=over 4

=item * L</type>

=back

=cut

__PACKAGE__->add_unique_constraint("type", ["type"]);

=head1 RELATIONS

=head2 sample_attr_type_aliases

Type: has_many

Related object: L<IMicrobe::Schema::Result::SampleAttrTypeAlias>

=cut

__PACKAGE__->has_many(
  "sample_attr_type_aliases",
  "IMicrobe::Schema::Result::SampleAttrTypeAlias",
  { "foreign.sample_attr_type_id" => "self.sample_attr_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sample_attr_type_category

Type: belongs_to

Related object: L<IMicrobe::Schema::Result::SampleAttrTypeCategory>

=cut

__PACKAGE__->belongs_to(
  "sample_attr_type_category",
  "IMicrobe::Schema::Result::SampleAttrTypeCategory",
  { sample_attr_type_category_id => "sample_attr_type_category_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);

=head2 sample_attrs

Type: has_many

Related object: L<IMicrobe::Schema::Result::SampleAttr>

=cut

__PACKAGE__->has_many(
  "sample_attrs",
  "IMicrobe::Schema::Result::SampleAttr",
  { "foreign.sample_attr_type_id" => "self.sample_attr_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2018-06-26 13:10:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xHX+4WSSlhXGVc7+/bKsaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
