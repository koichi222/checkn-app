class SessionController < ApplicationController

  def new
  end

  def create
    mail     = params[:mail]
    password = params[:password]

    res = AkerunClient.new.execute :login,
      "mail" => mail,
      "password" => password

    if res[:success]
      user_id = res[:user][:id]
      access_token = res[:access_token]
      session[:access_token] = access_token
      # TODO: 現状ではホテルユーザーは固定の想定
      token = AccessToken.find_by(user_id: user_id)
      if token.present?
        token.token = access_token
        token.save!
      else
        AccessToken.create!(
          user_id: user_id,
          token: access_token
        )
      end
      redirect_to "/hotels/1/bookings"
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
