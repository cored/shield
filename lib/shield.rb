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
      policies << Policy.new(policy)
      self
    end

    def apply
      policies.all?(&:validate)
    end

    def apply!
      policies.each(&:validate!)
    end

    private

    attr_reader :policies

    class Policy
      def initialize(policy)
        @exception = build_exception(policy)
        @policy = policy
      end

      def validate
        policy.validate
      end

      def validate!
        raise exception.new unless policy.validate
      end

      private

      def build_exception(policy)
        klass = Class.new StandardError do
        end
        Object.const_set "#{policy.class}Error", klass
        klass
      end

      attr_reader :policy, :exception
    end
  end
end

