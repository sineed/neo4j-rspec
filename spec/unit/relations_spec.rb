require "spec_helper"

RSpec.describe "Relations" do
  describe Contains do
    it { is_expected.to come_from(:Post) }
    it { is_expected.not_to come_from(:Comment) }
    it { is_expected.to lead_to(:Comment) }
    it { is_expected.not_to lead_to(:any) }
    it { is_expected.to have_relationship_type("contains") }
    it { is_expected.not_to have_relationship_type("wrong_type") }
  end

  describe Wrote do
    it { is_expected.to come_from(:Person) }
    it { is_expected.to lead_to(:any) }
    it { is_expected.to have_relationship_type("WROTE") }

    context "relation with create unique clause" do
      before { Wrote.creates_unique }
      it { is_expected.to use_create_unique }
      it { is_expected.to use_create_unique(:none) }

      context "all option" do
        before { Wrote.creates_unique(:all) }
        it { is_expected.to use_create_unique(:all) }
        it { is_expected.not_to use_create_unique(:none) }
      end

      context "on: [keys] option" do
        before { Wrote.creates_unique(on: [:uid]) }
        it { is_expected.to use_create_unique(on: [:uid]) }
        it { is_expected.not_to use_create_unique(on: [:wrong_key]) }
      end
    end
  end
end
