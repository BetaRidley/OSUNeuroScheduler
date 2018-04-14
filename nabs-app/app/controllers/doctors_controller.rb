class DoctorsController < ApplicationController
  before_action :check_referring_clinic_auth
  before_action :clinic_check

  def search
    filter_doctor
  end

  def select_doctor
    @doctor = User.find(doctor_params[:id])
    @referral = Referral.new(referred_doctor_id: @doctor.id, created_by_id: current_user.id,
                             specialization_id: @doctor.specialization.id)
    if @referral.save
      flash[:message] = "Created Referral for Physician #{@doctor.full_name}"
      redirect_to edit_referral_path(id: @referral.id)
    else
      flash[:alert] = referral.errors.full_messages
      redirect_to doctors_path
    end
  end

  private
  def filter_doctor
    unless doctor_params.blank?
      name = doctor_params[:name] unless doctor_params[:name].blank?
      @clinic = Clinic.find(doctor_params[:clinic_id]) unless doctor_params[:clinic_id].blank?
      if doctor_params[:specialization_id].blank?
        @specialization = Condition.find(doctor_params[:condition_id]).specialization unless doctor_params[:condition_id].blank?
      else
        @specialization = Specialization.find(doctor_params[:specialization_id])
      end
    end
    unless @clinic.blank?
      @doctors = @doctors.where(clinic_id: @clinic.id)
    end
    unless @specialization.blank?
      @doctors = @doctors.where(specialization_id: @specialization.id)
    end
    unless name.blank?
      @doctors = @doctors.where('first_name LIKE :n',n: '%'+name+'%')
        .or(@doctors.where('last_name LIKE :n',n: '%'+name+'%'))
    end
    if @doctors.blank?
      flash[:notice] = 'No Physicians Found'
    end
  end
  def doctor_params
    params
      .permit(
        :id,
        :name,
        :clinic_id,
        :specialization_id,
        :condition_id
      )
  end
  def clinic_check
    @specializations = Specialization.all
    @conditions = Condition.all
    @clinics = Clinic.where(role: 'referred')
    @doctors = User.where(role: 'doctor').where(clinic: @clinics)
  end
end
