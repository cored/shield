module Shield
  class Policy
    def initialize(policy)
      @policy = policy
    end

    def validate
      policy.validate
    end

    def validate!
      raise exception.new(policy.error) unless policy.validate
    end

    private

    def exception
      @exception ||= build_exception
    end

    def build_exception
      Object.const_set klass_name, super_klass unless Object.const_defined? klass_name
    end

    def klass_name
      @klass_name ||= "#{policy.class}Error"
    end

    def super_klass
      @super_klass ||= Class.new(StandardError)
    end

    attr_reader :policy
  end
end
