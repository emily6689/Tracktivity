class LogsController < ApplicationController

  def index
    @activities = current_user.activities
    @logs = current_user.logs
    if params[:q]
        if params[:q]['date'] != ''
          query_date = Date.parse(params[:q][:date])
          @queried_logs       = @logs.sort_by_week(query_date)
          @queried_activities = @queried_logs.list_activities
          @total_productivity = @queried_logs.total_productivity
          binding.pry
          @queried_categories = @queried_logs.list_categories
          render :index
        else
          flash[:notice] = "Please select a valid date."
      end
    end
  end

  def create
    @log = Activity.find(params[:activity_id]).incomplete_logs.take
    if @log
      @log.time_clocked_out = DateTime.now
    else
      @log = Log.new(time_clocked_in: DateTime.now, activity_id: params[:activity_id])
    end
    if @log.save
      respond_to do |format|
        format.json { render json: @log }
      end
    end
  end
end
