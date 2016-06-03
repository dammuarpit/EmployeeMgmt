class HomeController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  def home

  end
end
