class ApplicationPetsController < ApplicationController

  def create
    if params[:search].present?
      pet = Pet.where(name: params[:search])
      application = Application.find(params[:application_id])
      app_pet = ApplicationPet.create(pet_id: pet[0].id, application_id: application.id)
      redirect_to "/applications/#{application.id}"
    end
  end

end