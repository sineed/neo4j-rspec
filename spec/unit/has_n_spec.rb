require "spec_helper"

RSpec.describe "Has N" do
  describe Post do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:comments).with_direction(:in) }
    it { is_expected.to have_many(:comments).with_direction(:in).with_origin(:post) }
    it { is_expected.to have_one(:author) }
    it { is_expected.to have_one(:author).with_direction(:out) }
    it { is_expected.to have_one(:author).with_direction(:out).with_type(:author) }
    it { is_expected.to have_one(:author).with_direction(:out).with_type(:author).with_model_class(:Person) }
  end

  describe Comment do
    it { is_expected.to have_one(:post) }
    it { is_expected.to have_one(:post).with_direction(:out) }
    it { is_expected.to have_one(:post).with_direction(:out).with_type(:post) }
    it { is_expected.not_to have_one(:post).with_model_class(:whatever) }
    it { is_expected.to have_one(:author) }
    it { is_expected.to have_one(:author).with_direction(:out) }
    it { is_expected.to have_one(:author).with_direction(:out).with_type(:author) }
    it { is_expected.to have_one(:author).with_direction(:out).with_type(:author).with_model_class(:Person) }
  end

  describe Person do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:posts).with_direction(:in) }
    it { is_expected.to have_many(:posts).with_direction(:in).with_origin(:author) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:comments).with_direction(:in) }
    it { is_expected.to have_many(:comments).with_direction(:in).with_origin(:author) }
    it { is_expected.to have_many(:written_things) }
    it { is_expected.to have_many(:written_things).with_direction(:in) }
    it { is_expected.to have_many(:written_things).with_direction(:in).without_type }
    it { is_expected.to have_many(:written_things).with_direction(:in).without_type.with_model_class(:Post, :Comment) }
  end
end
