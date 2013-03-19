class CarouselsController < ApplicationController
  # GET /carousels
  # GET /carousels.json
  def index
    @carousels = Carousel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carousels }
    end
  end

  # GET /carousels/1
  # GET /carousels/1.json
  def show
    @carousel = Carousel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carousel }
    end
  end

  # GET /carousels/new
  # GET /carousels/new.json
  def new
    @carousel = Carousel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carousel }
    end
  end

  # GET /carousels/1/edit
  def edit
    @carousel = Carousel.find(params[:id])
  end

  # POST /carousels
  # POST /carousels.json
  def create
    @carousel = Carousel.new(params[:carousel])

    respond_to do |format|
      if @carousel.save
        format.html { redirect_to @carousel, notice: 'Carousel was successfully created.' }
        format.json { render json: @carousel, status: :created, location: @carousel }
      else
        format.html { render action: "new" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carousels/1
  # PUT /carousels/1.json
  def update
    @carousel = Carousel.find(params[:id])

    respond_to do |format|
      if @carousel.update_attributes(params[:carousel])
        format.html { redirect_to @carousel, notice: 'Carousel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carousels/1
  # DELETE /carousels/1.json
  def destroy
    @carousel = Carousel.find(params[:id])
    @carousel.destroy

    respond_to do |format|
      format.html { redirect_to carousels_url }
      format.json { head :no_content }
    end
  end
end
