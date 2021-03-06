class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.where(user: current_user)
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      @activity.categories = Category.find_all_by_id(params[:activity][:category_ids])
      flash[:notice] = "You're activity was successfully created. Yay!"
      redirect_to activity_path(@activity)
    else
      flash[:notice] = "Please fill out all the required fields."
      render :new
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @log = @activity.incomplete_logs.last
  end

  private

  def activity_params
    params.require(:activity).permit(:name).merge(user_id: current_user.id)
  end

end
