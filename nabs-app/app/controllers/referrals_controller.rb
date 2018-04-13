class ReferralsController < ApplicationController
  before_action :check_referring_clinic_auth

  def send_referral
    @referral = @referrals.find(params[:id])
    if @referral
      @patient = @referral.patient
      if @patient.update_attributes(patient_params)
        if @referral.update_attributes(status: @referral.referred_doctor.auto_approve? ? 3 : 2)
          flash[:notice] =  "Referral Sent"
          PatientMailer.send_accept_message(@referral).deliver_now! if @referral.status == 3
          redirect_to home_index_path
        else
          flash[:alert] =  @referral.errors.full_messages
          redirect_to assign_patient_path(patient_params)
        end
      else
        flash[:alert] =  @patient.errors.full_messages
        redirect_to assign_patient_path(patient_params)
      end
    else
      flash[:alert] =  "Referral does not belong to your office"
      redirect_to referrals_path
    end
  end

  before_action :clinic_check

  def index
    @statuses = ['new', 'edited', 'sent', 'accepted','denied']
  end

  def new
    @referral = Referral.new

    @referring_doctors =
      User
      .where(role: :doctor, clinic_id: current_user.clinic_id)
      .map{|u| [u.full_name, u.id]}
    @referred_doctors =
      User
      .where(role: :doctor)
      .where.not(clinic_id: current_user.clinic_id)
      .map{|u| [u.full_name, u.id]}

    @specialties =
      Specialization.all
      .map{|s| [s.title, s.id]}
  end

  def create
    @referral = Referral.new(referral_params)

    @referring_doctors =
      User
      .where(role: :doctor, clinic_id: current_user.clinic_id)
      .map{|u| [u.full_name, u.id]}

    @specialties =
      Specialization.all
      .map{|s| [s.title, s.id]}

    @referral.created_by = current_user
    @referral.patient = Patient.create!
    @referral.status = 0
    if @referral.save
      flash[:notice] = "Referral Created"
      redirect_to assign_patient_path(@referral.patient_id)
    else
      flash[:alert] =  @referral.errors.full_messages
      redirect_to new_referral_path(referral_params)
    end
  end

  def edit
    @referral = @referrals.find(params[:id])
    @specialties =
      Specialization.all
      .map{|s| [s.title, s.id]}
  end

  def update
    @referral = @referrals.find(params[:id])
    @referral.patient = Patient.create! unless @referral.patient
    if @referral.update_attributes(referral_params)
      @referral.update_attribute(:status, 1)
      flash[:notice] = "Referral Updated"
      redirect_to assign_patient_path(@referral.patient_id)
    else
      flash[:alert] =  @referral.errors.full_messages
      redirect_to edit_referral_path(params[:id])
    end
  end

  def destroy
    @referral = @referrals.find(params[:id])
    if @referral.destroy
      flash[:alert] =   "Deleted Referral #{@referral.id}"
      redirect_to referrals_path
    else
      flash[:alert] =  @referral.errors.full_messages
      redirect_to referrals_path
    end
  end

  def assign_patient
    @patient = Patient.find(params[:id])
    unless @referrals.include?(@patient.referral)
      flash[:alert] =  "Patient does not belong to a referral generated by your office"
      redirect_to referrals_path
    else
      @sexes = [['Female','F'],['Male','M'],['Unknown','U']]
    end
  end

  private
  def referral_params
    params
      .require(:referral)
      .permit(
        :urgent,
        :next_available,
        :specialization_id,
        :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
        :referring_doctor_id,
        :referred_doctor_id
      )
  end
  def patient_params
    params
      .require(:patient)
      .permit(
        :ssn,
        :first_name,
        :middle_name,
        :last_name,
        :birth_date, :sex,
        :fax_number, :phone_number, :email,
        :insurance, :plan_group_no,
        :address_line1, :address_line2, :city, :state, :zip_code
      )
  end

  def clinic_check
    # matches clinic of creator of referral
    #reject those that have not been sent
    # nil default, 1 pending, 2 sent, 3 accept, 4 denied
    @referred_doctors = User.referred.map{|d| [d.full_name, d.id]}
    @referring_doctors = Clinic.find(current_user.clinic_id).referring_doctors
    @referrals = Referral.from_clinic(current_user.clinic).where(status: [nil,0,1])
  end
end
