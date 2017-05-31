# Neo4j::Rspec [![Build Status](https://travis-ci.org/sineed/neo4j-rspec.svg?branch=master)](https://travis-ci.org/sineed/neo4j-rspec)

This gem contains of several testing one-liners for [neo4j](https://github.com/neo4jrb/neo4j) gem.

## Install

Add line into your Gemfile:
```ruby
gem "neo4j-rspec"
```
or install it directly

```
gem install neo4j-rspec
```

Then configure it in your `spec_helper` (or `rails_helper`):

```ruby
RSpec.configure do |config|
  config.include Neo4j::RSpec::Matchers
  # ... other configuration ...
end
```

## Examples

### ActiveNode matchers:

- Properties

        it { is_expected.to define_property :general }
        it { is_expected.to define_property :string, :String }
        it { is_expected.to define_property :boolean, :Boolean }
        it { is_expected.to define_property :boolean, :'Neo4j::Shared::Boolean' }
- Relationships

        it { is_expected.to have_many(:comments) }
        it { is_expected.to have_many(:comments).with_direction(:in) }
        it { is_expected.to have_many(:comments).with_direction(:in).with_origin(:post) }
        it { is_expected.to have_many(:written_things).with_direction(:in).without_type.with_model_class([:Post, :Comment]) }
- Constraints

        it { is_expected.to define_constraint :name, :unique }
- Indexes

        it { is_expected.to define_index(:index_name) }
- Tracking

        it { is_expected.to track_creations } # `created_at`
        it { is_expected.to track_modifications } # `updated_at`


### ActiveRel matchers:

- Directions

        it { is_expected.to come_from(:Person) }
        it { is_expected.to lead_to(:any) }
- Types

        it { is_expected.to have_relationship_type("WROTE") }

- Create Unique

        it { is_expected.to use_create_unique }
        it { is_expected.to use_create_unique(:all) }
        it { is_expected.to use_create_unique(on: [:key1, :key2]) }


## Need yet another matcher?

Welcome! Feel free to post an [issue](https://github.com/sineed/neo4j-rspec/issues/new). Contributions are welcome too.
