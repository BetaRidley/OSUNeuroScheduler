class ClinicsController < ApplicationController
  before_action :check_admin_auth

  def index
    @clinics = Clinic.all
  end

  def show
    @clinic = Clinic.find(params[:id])
  end

  def new
    @roles = [['Referrer','referrer' ], ['Referred', 'referred']]
    @clinic = Clinic.new
  end

  def create
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      flash[:notice] = "Created Clinic #{@clinic.name}"
      redirect_to clinics_path
    else
      flash[:alert] = @clinic.errors.full_messages
      redirect_to new_clinic_path
    end
  end

  def edit
    @roles = [['Referrer','referrer' ], ['Referred', 'referred']]
    @clinic = Clinic.find(params[:id])
  end

  def update
    @clinic = Clinic.find(params[:id])
    if @clinic.update_attributes(clinic_params)
      flash[:notice] = "Updated Clinic #{@clinic.name}"
      redirect_to clinics_path
    else
      flash[:alert] = @clinic.errors.full_messages
      redirect_to edit_clinic_path(params[:id])
    end
  end


  # New version of destroy
  def destroy
    @clinic = Clinic.find(params[:id])
    flash[:notice]="Deleted Clinic"
    @resultDel = @clinic.destroy

    # if destroy doesn't work, throw the error message
    if not @resultDel
      flash[:alert]=@clinic.errors.full_messages
    end

    # always redirect back to clinics page
    redirect_to clinics_path
  end

  private
  def clinic_params
    params.require(:clinic)
    .permit(
      :role,
      :name,
      :phone_number, :fax_number,
      :address_line1, :address_line2,
      :city, :state, :zip_code
    )
  end
end
