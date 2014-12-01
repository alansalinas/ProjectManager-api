class LoginController < ApplicationController
  
  def create
    p "UNO"
    request = params[:request]
    
    p " P REQUEST"
    p request
    res = Request.login(request)
    
      p res['code']
      
  render json: res
  end # end create
  
  
  #
  # sobreescribir el token de autenticacion si el usuario
  # quiere forzar el login de otro dispositivo
  def overwrite
    
    request = params[:request]
    
    p " P REQUEST"
    p request
    res = Request.forcelogin(request)
    
      p res['code']
      
  render json: res
    
  end # end overwrite
  
  #
  # "Delete" a login, aka "log the user out"
  def destroy
       
    request = params[:request]
    
    p " P REQUEST"
    p request
    res = Request.logout(request)
    

      p res['code']
      
  
  render json: res
  end # end destroy
  
  #
  # Nuevo user account
  def new
    
    request = params[:request]
    
    res = Request.signup(request)
    
    render json: res
    
  end 
  
  
  #
  # Deja notificacion de que el usuario quiere cambio de password
  def forgot
    
    request = params[:request]
    
    res = Request.forgotPass(request)
    
    render json: res
    
  end   # end forgot password

end
