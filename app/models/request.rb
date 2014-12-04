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
  def self.sync(req)
    p "PRINT req"
    p req # debug
    
    
    
    if req[:auth_token] == nil
      auth_token = req[:auth_token]
      p auth_token
      p "AUTH TOKEN NIL"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    else # autenticar manualmente por que no hay metodo en controller aqui
      auth_token = req[:auth_token]
      p auth_token
      current_user = User.find_by(auth_token: auth_token)
      p "AUTH NO NIL"
      p current_user
      
    if current_user != nil
      p current_user.nombre
      p current_user.id
      json_res = {:status => "OK", :code => 6, :nombre => current_user.nombre, :id => current_user.id, :description => "Succesful API call"}
      p "HAY USER"
    else
      p "NOHAY USER"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    end
    
  end #end authtoken nil
  
  return json_res
  
  end # end validate
  
  def self.getprojects(req)
    p "PRINT req getproejcts"
    p req # debug
    
    
    
    if req[:auth_token] == nil
      auth_token = req[:auth_token]
      p auth_token
      p "AUTH TOKEN NIL"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    else # autenticar manualmente por que no hay metodo en controller aqui
      auth_token = req[:auth_token]
      p auth_token
      current_user = User.find_by(auth_token: auth_token)
      p "AUTH NO NIL"
      p current_user
      
    if current_user != nil
      p current_user.nombre
      p current_user.id
      json_res = {:status => "OK", :code => 8, :nombre => current_user.nombre, :id => current_user.id, :description => "Succesful API call"}
      p "HAY USER"
    else
      p "NOHAY USER"
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    end
    
  end #end authtoken nil
  
  return json_res
  
  end # end getprojects
  
  
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
      
    
    if user = User.authenticate(nombre, pass)
      
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
    
  end   # end forcelogin
  
  
  #
  # Crea cuenta de usuario nueva en base de datos
  def self.signup(req)
    
    nombre = req[:nombre]
    pass = req[:password]
    email = req[:email]
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if nombre != nil && pass != nil && email != nil
      
    p "nomre: " + req[:nombre]
    p "pass: " + req[:password]
    p "email: " + req[:email]
    
    u = User.find_by(:nombre => nombre)
    if u == nil
    user = User.new
      
    key = Devise.friendly_token
    user.auth_token = key
    user.nombre = nombre
    user.password = pass
    user.request_pass = 0
    user.save
      
    json_res = {:status => "OK", :code => 7, :nombre => user.nombre, :id => user.id, :auth_token => key} # account created
    end
    # noname or password, json response already set
    end
  
  return json_res
    
    
  end     # end signup
  
  
  #
  # notificacion para user que necesita cambio de password
  def self.forgotPass(req)
    
    nombre = req[:nombre]
    
    json_res = {:status => "ERROR", :code => 0, :description => "No name/password"}
    
    if nombre != nil
      
    p "nombre: " + req[:nombre]
    
    
    user = User.find_by(:nombre => nombre)
    
    if user != nil
      json_res = {:status => "OK", :code => 8, :nombre => nombre} # password change notified
      user.request_pass = 1
    end
    
      
    # noname or password, json response already set
    end
  
  return json_res
  end   # end forgotPass
  
end # end class Request
