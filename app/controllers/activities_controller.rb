class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    if @activity.save
      flash[:notice] = "You're activity was successfully created. Yay!"
      redirect_to activity_path(@activity)
    else
      flash[:notice] = "Please fill out the appropriate information."
      render :new
    end
  end

  def show
  end

  private

  def activity_params
    params.require(:activity).permit(:name)
  end

end
