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
      @activity.categories = Category.find_all_by_id(params[:activity][:category_ids])
      flash[:notice] = "You're activity was successfully created. Yay!"
      redirect_to activity_path
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
