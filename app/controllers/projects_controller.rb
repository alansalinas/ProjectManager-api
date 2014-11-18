class ProjectsController < ApplicationController
  
  # GET API
  # returns an array of all the projects owned by the user authenticated via the token provieded
  #
  def get
    if params[:auth_token] == nil
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    else
    @current_user = current_user(params[:auth_token])
    if @current_user != nil
      json_res = {:status => "OK", :code => 6, :description => "Get Projects"}
      
    else
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
    end
    
  end #end authtoken nil
    
  render json: json_res
    
  end #end get



  # UPDATE API
  # Creates one or more entries in the Project model database, according to the entries provided
  # in the JSON request object
  # 
  def sync
    
    if params[:auth_token] == nil
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
      
    else # hay token en parametro auth_token
      @current_user = current_user(params[:auth_token])
      if @current_user != nil
        json_res = {:status => "OK", :code => 7, :description => "Projects and tasks synced with database"}
        # ejectuar el sync
        
        
      else # no encontro user con el token dado
        json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
        
      end # end current_user==nil
      
    end # end auth_token param == nil
    
    render json: json_res
    
  end # end sync
  
  
  
  def getJSON
    
  end
  
  
  
  # DELETE API
  # Destroys Project model on server database that matches all the fields provided in JSON request
  # or parameters, as the UPDATE API this call can delete one or several entries if an array is provided
  #
  def delete
    
    if params[:auth_token] == nil
      json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
      
    else # hay token en parametro auth_token
      # destruir entradas
      @current_user = current_user(params[:auth_token])
      if @current_user != nil
        json_res = {:status => "OK", :code => 7, :description => "Projects added to database"}
        
      else # no encontro user con el token dado
        json_res = {:status => "ERROR", :code => 1, :description => "Invalid auth token"}
        
      end # end current_user==nil
      
    end # end auth_token param == nil
    
    render json: json_res
    
  end # end delete
  
  
end # end projectscontroller
