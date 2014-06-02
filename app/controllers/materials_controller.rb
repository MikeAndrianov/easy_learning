class MaterialsController < ApplicationController
  def create
    @section=Section.find(params[:section_id])
    @section.materials.create( material_params )
    redirect_to :back
  end

  private 
  def material_params
    params.require(:material).permit(:file)
  end
end
