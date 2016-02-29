# Neo4j::Rspec [![Build Status](https://travis-ci.org/sineed/neo4j-rspec.svg?branch=master)](https://travis-ci.org/sineed/neo4j-rspec)

## Examples

```ruby
subject { ModelClass }

# Properties

it { is_expected.to define_property :general }
it { is_expected.to define_property :string, String }
it { is_expected.to define_property :boolean, Boolean } # This might need to be `ActiveAttr::Typecasting::Boolean`

it { is_expected.to have_many(:written_things).with_direction(:in).without_type.with_model_class([:Post, :Comment]) }

# etc...

# `has_one` and `has_many`

it { is_expected.to have_many(:comments) }
it { is_expected.to have_many(:comments).with_direction(:in) }
it { is_expected.to have_many(:comments).with_direction(:in).with_origin(:post) }

# Constraints

it { is_expected.to define_constraint :name, :unique }

# `created_at` and `updated_at`

it { is_expected.to track_creations } # `created_at`
it { is_expected.to track_modifications } # `updated_at`

```

TODO: Put some examples of usage:
- [ ] define_index
- [ ] come_from_model
- [ ] lead_to_model
