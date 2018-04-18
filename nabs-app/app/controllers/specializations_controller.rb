class SpecializationsController < ApplicationController
  before_action :check_admin_auth

  def index
    @specializations = Specialization.all
    @specialization = Specialization.new
    @conditions = Condition.all
    @condition = Condition.new
  end

  def show
    @specialization = Specialization.find(params[:id])
  end

  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = Specialization.new(specialization_params)
    if @specialization.save
      flash[:notice] = "Created Specialization #{@specialization.title}"
    else
      flash[:alert] = @specialization.errors.full_messages
    end
    redirect_to specializations_path
  end

  def create_condition
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:notice] = "Created Condition #{@condition.name}"
    else
      flash[:alert] = @condition.errors.full_messages
    end
    redirect_to specializations_path
  end

  def edit
    @specialization = Specialization.find(params[:id])
  end

  def update
    @specialization = Specialization.find(params[:id])
    if @specialization.update_attributes(specialization_params)
      flash[:notice] = "Updated Specialization #{@specialization.name}"
      redirect_to specializations_path
    else
      flash[:alert] = @specialization.errors.full_messages
      redirect_to edit_specialization_path(params[:id])
    end
  end

  # New version of destroy
  def destroy
    begin
      @specialization = Specialization.try(:find, params[:id])
      flash[:notice] = 'Deleted Specialization'
      @result = @specialization.destroy
      # if destroy doesn't work, throw the error message
      flash[:alert] = @specialization.errors.full_messages unless @result
    rescue => e
      flash[:alert] = "Unknown Error trying to delete specialization #{params[:id]}, Errors: #{e}"
    ensure
      # always redirect back to specializations page
      redirect_to '/specializations/'
    end
  end

  def destroy_condition
    begin
      @condition = Condition.find(params[:id])
      flash[:notice] = 'Deleted Condition'
      @result = @condition.destroy
      # if destroy doesn't work, throw the error message
      flash[:alert] = @condition.errors.full_messages unless @result
    rescue => e
      flash[:alert] = "Unknown Error trying to delete condition #{params[:id]}, Errors: #{e}"
    ensure
      # always redirect back to specializations page
      redirect_to '/specializations/'
    end
  end

  private

  def specialization_params
    params.require(:specialization)
          .permit(:title)
  end

  def condition_params
    params.require(:condition)
          .permit(:name, :specialization_id)
  end
end

