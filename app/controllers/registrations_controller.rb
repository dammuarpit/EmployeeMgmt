class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end


  def update
    # required for settings form to submit when password is left blank
    # if account_update_params[:password].blank?
    #   [:password,:password_confirmation,:current_password].collect{|p| account_update_params.delete(p) }
    # end
    # if account_update_params[:password].present? and account_update_params[:current_password].blank?
    #   [:current_password].collect{|p| account_update_params.delete(p) }
    # end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected
  def update_resource(resource, params)
    if params[:password].blank? && params[:current_password].blank?
      ### update user (without password) when current_pwd given/not_given  ###
      # resource.update_attributes(params.reject { |k, v| %w(password password_confirmation current_password).include? k })

      ## update user data except password when password and current_pwd not given.
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)   ### update user with password when current_pwd given ###
      # resource.update_attributes(params.reject { |k, v| %w(current_password).include? k })
    end
  end
end
