require "shield/version"

module Shield
  def policies
    Policies
  end

  class Policies
    def self.with(klass, *args)
      new.with(klass, *args)
    end

    def initialize
      @policies = []
    end

    def with(klass, *args)
      @policies << Policy.new(klass, args)
      self
    end

    def apply!
      @policies.inject(&:validate)
    end
  end

  class Policy
    def initialize(klass, args)
      @klass = klass
      @args = args
    end

    def validate
      klass.new.validate(args)
    end

    private

    attr_reader :klass, :args
  end
end
