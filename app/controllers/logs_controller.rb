class LogsController < ApplicationController

  def index
    @activities = current_user.activities
    @logs = current_user.logs
    if params[:q]
      query_date = DateTime.new(params[:q]["date(1i)"].to_i, params[:q]["date(2i)"].to_i, params[:q]["date(3i)"].to_i)
      @queried_logs = @logs.sort_by_week(query_date)
      @categories = @queried_logs.list_categories
      binding.pry
      render :index
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
