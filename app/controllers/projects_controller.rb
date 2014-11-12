class ProjectsController < ApplicationController
  def get
    if params[:auth_token] == nil
      render plain: "ERROR NO TOKEN"
    else
    @current_user = current_user(params[:auth_token])
    if @current_user != nil
      render plain: "HAY USER"
    else
      render plain: "NO USER"
    end
    
  end
    
  end

  def update
  end
end
