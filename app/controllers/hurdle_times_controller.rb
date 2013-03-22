class HurdleTimesController < ApplicationController
  # GET /hurdle_times
  # GET /hurdle_times.json
  def index

    @hurdle_times = HurdleTime.order('hurdle_match_id, lane')

    if params[:hurdle_match_id]
      @hurdle_times = @hurdle_times.where(:hurdle_match_id => params[:hurdle_match_id])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hurdle_times }
    end
  end

  # GET /hurdle_times/1
  # GET /hurdle_times/1.json
  def show
    @hurdle_time = HurdleTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hurdle_time }
    end
  end

  # GET /hurdle_times/1/edit
  def edit
    @hurdle_time = HurdleTime.find(params[:id])
  end

  # PUT /hurdle_times/1
  # PUT /hurdle_times/1.json
  def update
    @hurdle_time = HurdleTime.find(params[:id])

    time = (params[:time][:minutes].to_i * 60) + params[:time][:seconds].to_i
    if params[:hurdle_time]
      params[:hurdle_time].store :time, time
    else
      params[:hurdle_time] = {}.store :time, time
    end

    respond_to do |format|
      if @hurdle_time.update_attributes(params[:hurdle_time])
        format.html { redirect_to @hurdle_time, notice: 'Hurdle time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hurdle_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hurdle_times/1
  # DELETE /hurdle_times/1.json
  def destroy
    @hurdle_time = HurdleTime.find(params[:id])
    @hurdle_time.destroy

    respond_to do |format|
      format.html { redirect_to hurdle_times_url }
      format.json { head :no_content }
    end
  end
end
