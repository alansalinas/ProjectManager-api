class LoginController < ApplicationController
  
  def create
    
    nombre = params[:nombre]
    pass = params[:password]
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if nombre != nil && pass != nil
      
    p params[:nombre]
    p params[:password]
    
    if user = User.authenticate(nombre, pass)
      # Save the user ID in the session so it can be used in
      # subsequent requests
      #session[:current_user_id] = user.id
      if user.auth_token != nil
        json_res = {:status => "ERROR", :code => 2, :description => "User already has a token, overwrite session token? /login/overwrite"}
      
      else
      p user.id
      
      key = Devise.friendly_token
      user.auth_token = key
      user.save
      
      json_res = {:status => "OK", :code => 4, :auth_token => key}  # sucess login
    end
    else
    # else not authenticated with nombre, pass
    json_res = {:status => "ERROR", :code => 3,  :description => "User nonexistent"}
    end
    
    # else noname or password
  end
  render json: json_res
  end
  
  
  #
  # sobreescribir el token de autenticacion si el usuario
  # quiere forzar el login de otro dispositivo
  def overwrite
    
    nombre = params[:nombre]
    pass = params[:password]
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if nombre != nil && pass != nil
      
    p params[:nombre]
    p params[:password]
    
    if user = User.authenticate(nombre, pass)
      # Save the user ID in the session so it can be used in
      # subsequent requests
      #session[:current_user_id] = user.id
      p user.id
      
      key = Devise.friendly_token
      user.auth_token = key
      user.save
      
      json_res = {:status => "OK", :code => 4, :auth_token => key}  # overwritten
      
    else
      
      # else not authenticated with nombre, pass
      json_res = {:status => "ERROR", :code => 0, :description => "User nonexistent"}
    end
    
    # noname or password, json response already set
    
  end
  render json: json_res
    
  end
  

    # "Delete" a login, aka "log the user out"
  def destroy
       # Remove the user id from the session
       #@_current_user = session[:current_user_id] = nil
       json_res = {:status => "ERROR", :code => 1, :description => "Invalid token"}
       
       user = User.find_by(auth_token: params[:auth_token])
       
       if user != nil
       user.auth_token = nil
       user.save
       json_res = {:status => "OK", :code => 5, :description => "Session destroyed"}
       
       end
       
       render json: json_red
  end

end
