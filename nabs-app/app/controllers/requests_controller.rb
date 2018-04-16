class RequestsController < ApplicationController
  before_action :check_referred_clinic_auth
  before_action :clinic_check, only: [:index, :accept, :deny]

  def index
    @statuses = ['new', 'edited', 'sent', 'accepted','denied']
  end

  def show
    @request = @requests.find(params[:id])
  end
  
  #def modify
  #  @request = @requests.find(params[:id])
  # TODO: get modify action set up for referrals on hospital end, so they can change date & send email to end pt for discussion
  #end

  def accept
    @request = @requests.find(params[:id])
    if @request.update_attribute(:status, 3)
      PatientMailer.send_accept_message(@request).deliver_now!
    else
      flash[:alert] = r.errors.full_messages
    end
    redirect_to requests_path
  end

  def deny
    @request = @requests.find(params[:id])
    if @request.update_attribute(:status, 4)
      UserMailer.send_deny_message(@request).deliver_now!
    else
      flash[:alert] = r.errors.full_messages
    end
    redirect_to requests_path
  end

  private

  def clinic_check
    #reject those that have not been sent
    # nil default, 1 pending, 2 sent, 3 accept, 4 denied
    @requests = Referral.where(status: [2,3,4])
  end
end
