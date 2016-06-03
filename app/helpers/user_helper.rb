module UserHelper

  def active_roles
    if @user.role_id.blank?
      @roles = ['no role']
    else
      @roles = @user.role_id.to_a.map { |id| Role.find_by(id: id).name }
    end
    @roles.join(',')
  end

end
