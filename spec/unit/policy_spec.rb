require "spec_helper"

class PolicyValidator
  attr_reader :user, :error

  def initialize(user)
    @user = user
    @error = "Something bad"
  end

  def validate
    user.valid?
  end
end

describe Shield::Policy do
  let(:user) { double :user, valid?: false }

  subject { Shield::Policy.new(PolicyValidator.new(user)) }

  describe "#validate" do
    it "returns false if the validation returns false" do
      expect(subject.validate).to eq(false)
    end
  end

  describe "#validate!" do
    it "raises an exception if the validation returns false" do
      expect do
        subject.validate!
      end.to raise_error
    end
  end
end
