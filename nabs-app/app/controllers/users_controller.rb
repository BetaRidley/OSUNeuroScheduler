class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, :only => [:edit, :show, :update, :destroy]
  before_action :check_admin_auth, :only => [:index, :destroy, :reset_password]
  before_action :check_doctor_auth, :only => [:new, :create]
  before_action :check_current_user, :only => [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
    if current_user.role == 'admin'
      @roles =[['Admin', 'admin'],['Doctor','doctor'],['Staff','staff']]
      @clinics =
        Clinic.all
        .map{|c| ["#{c.name} - #{c.address_line1}", c.id]}
    else
      @roles = [['Doctor','doctor'],['Staff','staff']]
      @clinics = [["#{current_user.clinic.name} - #{current_user.clinic.address_line1}", current_user.clinic_id]]
    end
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    @clinics =
      Clinic.all
      .map{|c| ["#{c.name} - #{c.address_line1}", c.id]}
    if @user.save
      User.invite!(email: @user.email) do |u|
        u.skip_invitation = true # Record created but invitation email will not be sent
      end
      redirect_to @user
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @roles = [['Admin', 'admin'],['Doctor','doctor'],['Staff','staff']]
    @clinics =
      Clinic.all
      .map{|c| ["#{c.name} - #{c.address_line1}", c.id]}
  end

  def show
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated User #{@user.full_name}"
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to edit_user_path(params[:id])
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to users_path
    end
  end

  def reset_password
    @user = User.find(params[:user_id])
    @user.confirmed_at = nil
    @user.password_changed = false
  	if @user.save
    	@user.send_confirmation_instructions
    	redirect_to @user #Change this
  	else
        flash[:alert] = @user.errors.full_messages
    	redirect_to users_path #Change this
  	end
    
  end

  private
  def check_current_user
   unless current_user.admin? or current_user == @user
     redirect_to unauthenticated_root_url, alert: "You do not have permission to view that page"
   end
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def same_clinic
    not (current_user.clinic.nil? or @user.clinic.nil?) and current_user.clinic == @user.clinic
  end

  def user_params
    if current_user.admin? || current_user.doctor?
      params.require(:user).
      permit(
        :role,
        :first_name,
        :last_name,
        :middle_name,
        :clinic_id,
        :fax_number,
        :phone_number,
        :email,
        :password,
        :password_confirmation,
        :invitation_token
      ).delete_if do |key, val|
        key == 'role' and val == "admin" and not current_user.admin?
      end
    elsif @user == current_user
      params.require(:user).
      permit(
        :first_name,
        :last_name,
        :middle_name,
        :clinic_id,
        :fax_number,
        :phone_number,
        :email,
        :password,
        :password_confirmation,
        :invitation_token
      )
    end
  end
end
