module Shield
  class Policies
    attr_reader :policies

    def self.with(policy)
      new.with(policy)
    end

    def initialize
      @policies = []
    end

    def with(policy)
      policies << Policy.new(policy)
      self
    end

    def apply
      policies.all?(&:validate)
    end

    def apply!
      policies.each(&:validate!)
    end
  end
end
