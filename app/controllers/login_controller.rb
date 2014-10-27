class LoginController < ApplicationController
  
  def create
    p params[:user][:nombre]
    if user = User.authenticate(params[:user][:nombre], params[:user][:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      p user.id
      render json: { status :ok}
    else
      render json: { status :error}
    end
    
  end

    # "Delete" a login, aka "log the user out"
  def destroy
       # Remove the user id from the session
       @_current_user = session[:current_user_id] = nil
       render json: { status :ok}
  end

end
