class ApplicationsController < ApplicationController
  before_action :sanitize_application_params

  def new
  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      redirect_to "/applications/#{new_app.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      render :new
    end
      
  end

  def show
    if params[:search]
      application_search
      @pets = Pet.where(name: params[:search])
      render :show
    end
    application_search
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :description, :status)
  end

  def sanitize_application_params
    params[:status] = params[:offset].to_i
  end

  def application_search
    @application = Application.find(params[:application_id])
  end
end