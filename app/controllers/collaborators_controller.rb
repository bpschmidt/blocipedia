class CollaboratorsController < ApplicationController

  def create
    Collaborator.create(params[:collaborator].permit!)
    redirect_to :back, notice: "Collaborator Added."
  end
end
