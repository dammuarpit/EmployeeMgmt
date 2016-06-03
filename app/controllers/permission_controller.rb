class PermissionController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_authorization!

  def index
    @permissions = Permission.order_by_asc.all
  end

  def show
    @permission = Permission.find(params[:id])
  end

  def new
    @permission = Permission.new
  end

  def edit
    @permission = Permission.find(params[:id])
  end

  def create
    @permission = Permission.new(permission_params)
    if @permission.save
      redirect_to @permission, notice: 'Permission was successfully created.'
    else
      render :new
    end
  end

  def update
    @permission = Permission.find(params[:id])
    if @permission.update_attributes(permission_params)
      redirect_to @permission, notice: 'Permission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @permission = Permission.find(params[:id])
    if @permission.destroy
      redirect_to permission_index_path, notice: 'Permission was successfully destroyed.'
    else
      render :index
    end
  end

  def role_permission_mgmt
    @roles = Role.order_by_asc.all
    @permission = Permission.order_by_asc.all
  end

  def dynamic_mgmt
    # hs = {}
    # ar= []
    params[:permission].each do |permission_id, role_ar|
      @permission = Permission.where(id: permission_id).update(role_id: role_ar)
      # role_ar.each do |role|
      #   ar.concat([role.to_s])
      # end
      # hs.merge!({permission_id.to_sym => ar.uniq})
    end
    redirect_to role_pref_mgmt_path, notice: 'Updated successfully.'
  end

  private
  def permission_params
    params.require(:permission).permit(:name, :description, :action, :subject_class, :condition, :block)
  end

  def validate_authorization!
    authorize! :manage, Permission
  end
end
