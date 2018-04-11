class ScheduledController < ApplicationController
  before_action :check_referred_clinic_auth
  before_action :clinic_check, only: [:index]

  def index
    @statuses = ['new', 'edited', 'sent', 'accepted','denied']
  end

  def show
    @appt = @appts.find(params[:id])
  end

  #def modify
  #  @request = @requests.find(params[:id])
  # TODO: get modify action set up for referrals on hospital end, so they can change date & send email to end pt for discussion
  #end


  private

  def clinic_check
    #reject those that have not been sent
    # nil default, 1 pending, 2 sent, 3 accept, 4 denied
    @appts = Referral.where(status: [2,3,4])
  end
end
