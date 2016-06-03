class SessionsController < Devise::SessionsController

  def create
    super
    # @current_ability ||= Ability.new(current_user)
    # store_permissions
  end

  def destroy
    super
    # delete_permissions
  end



  def store_permissions

    if current_user.role_id.blank?
      $roles = []
      $permissions = []
    else
      $permissions = []
      $roles = current_user.role_id
      $roles.each do |role|
        $permissions.push(Role.find_by(id: role))
      end
    end

    if current_user.role_id.blank?
      $roles = []
      $permissions = []
    else
      $roles = []
      $permissions = []
      current_user.role_id.each do |role|
        # $roles.push(Role.find_by(id: role))
        role_obj = Role.find_by(id: role)
        $permissions.push(role_obj.permissions)
      end
    end
  end

  def delete_permissions
    $roles = nil
    $permissions = nil
  end

end
