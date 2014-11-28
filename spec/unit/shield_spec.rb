require "spec_helper"

class Validator
  include Shield
end

describe Shield do
  subject { Validator.new }

  describe "#policies" do
    it "returns the policies constant" do
      expect(subject.policies).to eq(Shield::Policies)
    end
  end
end
