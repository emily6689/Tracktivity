class RoleConstraint
  def matches?(request)
    request.env['warden'].user
  end
end
