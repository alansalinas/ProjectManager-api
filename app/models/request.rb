class Request < ActiveRecord::Base
  
  def status(jsonObject)
    p jsonObject
    return jsonObject['status']
  end
  
  def code(jsonObject)
    p jsonObject
    return jsonObject['code']
  end
  
  def self.print(a)
    p a
    return 1
  end
  
  
  #
  # Validate the API request json and return corresponding response with CODE
  def self.validate(req)
    p "PRINT req"
    p req # debug
    
    
    
    if req[:auth_token] == nil
      auth_token = req[:auth_token]
      p auth_token
      p "AUTH TOKEN NIL"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    else # autenticar manualmente por que no hay metodo en controller aqui
      current_user = User.find_by(auth_token: auth_token)
      p "AUTH NO NIL"
      auth_token = req[:auth_token]
      p auth_token
    if current_user != nil
      json_res = {:status => "OK", :code => 6, :nombre => current_user.nombre, :id => current_user.id, :description => "Succesful API call"}
      p "HAY USER"
    else
      p "NOHAY USER"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    end
    
  end #end authtoken nil
  
  return json_res
  
  end # end validate
  
  
  #
  # validates de API request for logins and registers the user in database, if user is previously
  # registered with another token, this method will not overwrite and will return error code
  def self.login(req)
    
    p "PRINT req login"
    p req
    
    nombre = req[:nombre]
    pass = req[:password]
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if req[:nombre] && req[:password]
      
      nombre = req[:nombre]
      pass = req[:password]
      
    p req[:nombre]
    p req[:password]
    
    if user = User.authenticate(nombre, pass)
      # Save the user ID in the session so it can be used in
      # subsequent requests
      #session[:current_user_id] = user.id
      if user.auth_token != nil
        json_res = {:status => "ERROR", :code => 2, :nombre => user.nombre, :id => user.id, :description => "User already has a token, overwrite session token? /login/overwrite"}
      
      else
      p user.id
      
      key = Devise.friendly_token
      user.auth_token = key
      user.save
      
      json_res = {:status => "OK", :code => 4, :nombre => user.nombre, :id => user.id, :auth_token => key}  # sucess login
    end
    else
    # else not authenticated with nombre, pass
    json_res = {:status => "ERROR", :code => 3,  :description => "User nonexistent"}
    end
    
    # else noname or password
  end
  
  return json_res
    
  end # end login
  
  
  
  #
  # validates the API request and if valid, destroys the auth_token for the session in the
  # databse, returns corresponding JSON response and CODE
  def self.logout(req)
    
    # Remove the user id from the session
    #@_current_user = session[:current_user_id] = nil
    json_res = {:status => "ERROR", :code => 1, :description => "Invalid token"}
    
    user = User.find_by(auth_token: req[:auth_token])
    
    if user != nil
    user.auth_token = nil
    user.save
    json_res = {:status => "OK", :code => 5, :nombre => user.nombre, :id => user.id, :description => "Session destroyed"}
    
    end
    
    return json_res
    
  end # logout
  
  
  #
  # Validates de API request, and if valid registers the user with an auth token in the database for
  # session, if token is already registered, this method generates a new one and overwrites it, returns
  # JSON response with CODE
  def self.forcelogin(req)
    
    nombre = req[:nombre]
    pass = req[:password]
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if nombre != nil && pass != nil
      
    p req[:nombre]
    p req[:password]
    
    if user = User.authenticate(nombre, pass)
      # Save the user ID in the session so it can be used in
      # subsequent requests
      #session[:current_user_id] = user.id
      p user.id
      
      key = Devise.friendly_token
      user.auth_token = key
      user.save
      
      json_res = {:status => "OK", :code => 4, :nombre => user.nombre, :id => user.id, :auth_token => key}  # overwritten
      
    else
      
      # else not authenticated with nombre, pass
      json_res = {:status => "ERROR", :code => 0, :description => "User nonexistent"}
    end
    
    # noname or password, json response already set
    
  end
  
  return json_res
    
  end
  
  
  
end # end class Request
