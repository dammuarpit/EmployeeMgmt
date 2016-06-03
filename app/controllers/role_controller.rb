class RoleController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_authorization!

  def index
    @roles = Role.order_by_asc.all
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to @role, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      redirect_to @role, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])
    a = 10
    Permission.in({ id: @role.permission_ids }).pull({role_id: @role.id}) unless @role.permission_ids.blank?
    User.in({ id: @role.user_ids }).pull({role_id: @role.id}) unless @role.user_ids.blank?
    @role.destroy
    redirect_to role_index_path, notice: 'Role was successfully destroyed.'
  end

  private
  def role_params
    params.require(:role).permit(:name, :description)
  end

  def validate_authorization!
    authorize! :manage, Role
  end


end
