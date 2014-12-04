class ProjectsController < ApplicationController
  
  # GET API
  # returns an array of all the projects owned by the user authenticated via the token provieded
  #
  def get
    p "GETOO"
    @request = params[:request]

    p " P REQUEST"
    p @request
    @res = Request.validate(@request)
    
    
    p @res
      
    if @res[:code] == 6 

      @res[:projects] = getProjects
      @res[:tasks] = getTasks
      
      
    end # end response to code succesful
    
    p "RES"
    p @res
  render json: @res
    
  end #end get



  # SYNC API
  # Creates one or more entries in the Project model database, according to the entries provided
  # in the JSON request object, deletes the ones that are not present in the JSON request from db
  # 
  def sync
    
    p "SYNC"
    @request = params[:request]

    p " P REQUEST"
    p @request
    res = Request.validate(@request)
    
    p "RESPONSE:"
    p res
    
    
    if res[:code] == 6
      
      # encontrar proyectos de usuario en db
      @projects = Project.where("user_id = ?", res[:id])
      
      p "DELTE ENTRIES"
      @projects.each do |p|
        p.delete  # eliminar los proyectos de la base de datos de este usuario
      end
      p "GET JSON PROJECTS"
      # Actualizar pryectos del JSON
      @projects = @request[:projects] # proyectos entregados en el API request
      
      # convertir a modelo de Rails para guardar en database
      if @projects != nil
      @projects.each do |j|
        p = Project.new
        p.name = j[:name]
        p.status = j[:status]
        p.user_id = res[:id].to_i
        p.local_id = j[:id].to_i
        p.yearstart = j[:yearstart].to_i
        p.monthstart = j[:monthstart].to_i
        p.daystart = j[:daystart].to_i
        p.yeardue = j[:yeardue].to_i
        p.monthdue = j[:monthdue].to_i
        p.daydue = j[:daydue].to_i
        p.opentasks = j[:opentasks].to_i
        p.totaltasks = j[:totaltasks].to_i
        p.contentpath = j[:contentpath]
        p.save    # guarda entrada de Project asignada a usuario en db
      end
    end #end projects nil
      
      
      # encontrar tasks de usuario en db
      @tasks = Task.where("user_id = ?", res[:id])
      
      p "DELTE TASK ENTRIES"
      @tasks.each do |t|
        t.delete  # eliminar los tasks de la base de datos de este usuario
      end
      p "GET JSON TASKS"
      # Actualizar tasks del JSON
      @tasks = @request[:tasks] # tasks entregados en el API request
      
      # convertir a modelo de Rails para guardar en database
      if @tasks != nil
      @tasks.each do |j|
        t = Task.new
        t.name = j[:name]
        t.status = j[:status]
        t.user_id = res[:id].to_i
        t.local_id = j[:id].to_i
        t.project_id = j[:project_id]
        t.priority = j[:priority]
        t.percentage = j[:percentage].to_i
        t.yearstart = j[:yearstart].to_i
        t.monthstart = j[:monthstart].to_i
        t.daystart = j[:daystart].to_i
        t.yeardue = j[:yeardue].to_i
        t.monthdue = j[:monthdue].to_i
        t.daydue = j[:daydue].to_i
        t.photopath = j[:photopath]
        t.description = j[:description]
        t.contentpath = j[:contentpath]
        t.save    # guarda entrada de Task asignada a usuario en db
      end
    end
      
      
    end # end response to code succesful
    
    
  render json: res
    
  end # end sync
  
  
  
  #
  # Metodo para retornar proyectos en hash array
  def getProjects
    # encontrar proyectos de usuario en db
     p "GET NETRIES FROM DATABASE"
    @projects = Project.where("user_id = ?", @res[:id])
    
    p "GET NETRIES FROM DATABASE"
    p @projects
    
    # convertir a modelo de Android para enviar en un json
    i = 0
    p_array = []
    
    @projects.each do |p| # iterar por los proyectos de la db

      j = {}
      j[:name] = p[:name]
      j[:status] = p[:status]
      j[:id] = p[:local_id]
      #j[:user_id] = @res[:id]
      
      p_array[i] = j
      p j
      i = i + 1
      
      
    end # end do
    p "P PARRAY"
    p p_array
    
    return p_array
    
    
  end   # end getProjects
  
  
  
  #
  # Metodo para retornar proyectos en hash
  def getTasks
    # encontrar tasks de usuario en db
    @tasks = Task.where("user_id = ?", @res[:id])
    
    p "GET TASK NETRIES FROM DATABASE"
    p @tasks
    
    # convertir a modelo de Android para enviar en un json
    i = 0
    t_array = []
    
    @tasks.each do |t| # iterar por los proyectos de la db

      j = {}
      j[:name] = t[:name]
      j[:status] = t[:status]
      j[:id] = t[:local_id]
      j[:project_id] = t[:project_id]
      #j[:user_id] = @res[:id]
      
      t_array[i] = j
      p j
      i = i + 1
      
      
    end # end do
    p "T ARRAY"
    p t_array
    
    return t_array
    
    
  end   # end getTasks
  
  
  
  
end # end projectscontroller
