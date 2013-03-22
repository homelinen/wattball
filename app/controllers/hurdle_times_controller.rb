class HurdleTimesController < ApplicationController
  # GET /hurdle_times
  # GET /hurdle_times.json
  def index
    @hurdle_times = HurdleTime.order('hurdle_match_id, lane').all

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

  # GET /hurdle_times/new
  # GET /hurdle_times/new.json
  def new
    @hurdle_time = HurdleTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hurdle_time }
    end
  end

  # GET /hurdle_times/1/edit
  def edit
    @hurdle_time = HurdleTime.find(params[:id])
  end

  # POST /hurdle_times
  # POST /hurdle_times.json
  def create
    @hurdle_time = HurdleTime.new(params[:hurdle_time])

    respond_to do |format|
      if @hurdle_time.save
        format.html { redirect_to @hurdle_time, notice: 'Hurdle time was successfully created.' }
        format.json { render json: @hurdle_time, status: :created, location: @hurdle_time }
      else
        format.html { render action: "new" }
        format.json { render json: @hurdle_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hurdle_times/1
  # PUT /hurdle_times/1.json
  def update
    @hurdle_time = HurdleTime.find(params[:id])

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
