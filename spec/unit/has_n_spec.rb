require "spec_helper"

RSpec.describe "Has N" do
  describe Post do
    it { is_expected.to have_many(:comments).with_direction(:in).with_origin(:post) }
    it { is_expected.to have_one(:author).with_direction(:out).with_type(:author).with_model_class(:Person) }
  end
end
