require "shield/version"

module Shield
  def policies
    Policies
  end

  class Policies
    def self.with(policy)
      new.with(policy)
    end

    def initialize
      @policies = []
    end

    def with(policy)
      policies << policy
      self
    end

    def apply
      policies.all?(&:validate)
    end

    private

    attr_reader :policies
  end
end

