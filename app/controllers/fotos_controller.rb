class FotosController < ApplicationController
  def create
    @foto = Foto.create( foto_params )
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def foto_params
    params.require(:foto).permit(:pica)
  end
end
