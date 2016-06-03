class UserController < ApplicationController


  before_filter :authenticate_user!
  before_filter :validate_authorization!
  before_filter :mongodb_logger_helper


  def index
    logger.warn 'warn1'
    logger.error 'error1'
    logger.debug 'debug1'
    logger.unknown 'unknown1'
    logger.fatal 'fatal1'
    @users = User.order_by_asc.all
    raise 'error raised'
  rescue => e
    # logger.error "error2 #{e}"
    puts "error2 #{e}"

  end

  def show
    @user = User.find(params[:id])
    @user.role_id.blank? ? @roles = ['no role'] : @roles = @user.role_id.to_a.map { |id| Role.find_by(id: id).name }
  end

  def edit
    authorize! :update, User
    @user = User.find(params[:id])
    @user.role_id.blank? ? @roles = ['no role'] : @roles = @user.role_id.to_a.map { |id| Role.find_by(id: id) }
  end

  def update
    authorize! :update, User
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, User
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_index_path, notice: 'User was successfully destroyed.'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :age, :description, :current_password, :password, :password_confirmation, roles: [])
  end

  def validate_authorization!
    authorize! :read, User
  end

  def mongodb_logger_helper
    MongodbLoggerHelper.logger(current_user)
  end
end
