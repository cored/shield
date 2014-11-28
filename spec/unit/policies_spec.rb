require "spec_helper"

class PolicyValidator
  attr_reader :user

  def initialize(user)
    @user = user
    @erro = "Something bad"
  end

  def validate
    user.valid?
  end
end

describe Shield::Policies do
  let(:user) { double :user, valid?: false }
  let(:validator) { PolicyValidator.new(user) }

  describe "#with" do
    it "assigns the policy to the policies array" do
      expect do
        subject.with(validator)
      end.to change(subject.policies, :size).by 1
    end
  end

  describe "#apply" do
    it "returns the validation result" do
      subject.with(validator)
      expect(subject.apply).to eq false
    end
  end

  describe "#apply!" do
    it "returns the validation result" do
      subject.with(validator)
      expect do
        subject.apply!
      end.to raise_error
    end
  end
end
