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
  end
end
