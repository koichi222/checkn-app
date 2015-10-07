class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  def authenticate
    res = AkerunClient.new.execute :validate_access_token,
      "access_token" => session[:access_token]

    if res['success']
      true
    else
      redirect_to login_path
    end
  end
end
