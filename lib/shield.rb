require "shield/version"

module Shield
  autoload :Policies, "shield/policies"
  autoload :Policy,   "shield/policy"

  def policies
    Policies
  end
end

