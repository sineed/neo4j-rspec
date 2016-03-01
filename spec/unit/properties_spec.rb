require "spec_helper"

RSpec.describe "Property matchers" do
  describe 'Post model' do
    subject { Post }

    describe 'define_property' do
      it { is_expected.to define_property(:title) }
      it { is_expected.to define_property(:published, ActiveAttr::Typecasting::Boolean) }

      it { is_expected.not_to define_property(:non_existant, ActiveAttr::Typecasting::Boolean) }
    end

    describe 'define_constraint' do
      it { is_expected.to define_constraint(:custom_constraint, :unique) }
      it { is_expected.not_to define_constraint(:comments, :unique) }
    end

    it { is_expected.to track_modifications }
    it { is_expected.to track_creations }
  end

  context 'A model which does not track creations / modifications' do
    subject { Comment }

    it { is_expected.not_to track_modifications }
    it { is_expected.not_to track_creations }
  end

  describe Person do
    it { is_expected.to define_index(:nickname) }
    it { is_expected.to define_index(:reserved) }
  end
end

