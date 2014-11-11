require 'spec_helper'

class DummyPolicy
  def validate(collaborator)
    collaborator
  end
end

class DummyService
  include Shield

  def do_something
    policies.with(DummyPolicy, true).apply!
  end
end

describe Shield do 
  describe '#apply!' do
    it 'execute all policies' do
      DummyService.new.do_something.must_equal true
    end
  end
end
