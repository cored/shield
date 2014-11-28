require 'spec_helper'

class DummyPolicy
  attr_reader :error

  def initialize(user, error='')
    @error = error
    @user = user
  end

  def validate
    @user.admin?
  end
end

class DummyService
  include Shield

  def initialize(user)
    @user = user
  end

  def do_something
    policies.with(DummyPolicy.new(@user)).apply
  end
end


class DummyExceptionService
  include Shield

  def initialize(user)
    @user = user
  end

  def do_something
    policies.with(DummyPolicy.new(@user, 'This policy failed')).apply!
  end
end

describe Shield do
  describe '#apply' do
    context 'when validation succeded' do
      let(:user) { double :user, admin?: true }

      it 'execute all policies' do
        expect(DummyService.new(user).do_something).to eql true
      end
    end

    context 'when validation failed' do
      let(:user) { double :user, admin?: false }

      it 'execute all policies' do
        expect(DummyService.new(user).do_something).to eql false
      end
    end
  end

  describe '#apply!' do
    context 'when validation failed' do
      let(:user) { double :user, admin?: false }

      it 'throws an exception' do
        expect {
          DummyExceptionService.new(user).do_something
        }.to raise_error("This policy failed")
      end
    end
  end
end
