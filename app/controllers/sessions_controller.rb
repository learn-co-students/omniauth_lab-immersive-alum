class SessionsController < ApplicationController
  def create
    if request.env['omniauth.auth']
      oauth_name = request.env['omniauth.auth']['info']['name']
      oauth_uid = request.env['omniauth.auth']['uid']
      user = User.find_by(:name => oauth_name)
      if user
        session[:user_id] = user.id
        @auth = request.env['omniauth.auth']
      else
        new_user = User.create(:name => oauth_name, :uid => oauth_uid)
        session[:user_id] = new_user.id
        @auth = request.env['omniauth.auth']
      end
    end
  end
end
