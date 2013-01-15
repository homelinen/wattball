class SportCentersController < ApplicationController
  # GET /sport_centers
  # GET /sport_centers.json
  def index
    @sport_centers = SportCenter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sport_centers }
    end
  end

  # GET /sport_centers/1
  # GET /sport_centers/1.json
  def show
    @sport_center = SportCenter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sport_center }
    end
  end

  # Consider making a contact controller
  def contact
    @message = nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: "mail form" }
    end
  end

  # GET /sport_centers/new
  # GET /sport_centers/new.json
  def new
    @sport_center = SportCenter.new
    @sport_center.build_contact

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sport_center }
    end
  end

  # GET /sport_centers/1/edit
  def edit
    @sport_center = SportCenter.find(params[:id])
  end

  # POST /sport_centers
  # POST /sport_centers.json
  def create
    @sport_center = SportCenter.new(params[:sport_center])

    respond_to do |format|
      if @sport_center.save
        format.html { redirect_to @sport_center, notice: 'Sport center was successfully created.' }
        format.json { render json: @sport_center, status: :created, location: @sport_center }
      else
        format.html { render action: "new" }
        format.json { render json: @sport_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sport_centers/1
  # PUT /sport_centers/1.json
  def update
    @sport_center = SportCenter.find(params[:id])

    respond_to do |format|
      if @sport_center.update_attributes(params[:sport_center])
        format.html { redirect_to @sport_center, notice: 'Sport center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sport_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_centers/1
  # DELETE /sport_centers/1.json
  def destroy
    @sport_center = SportCenter.find(params[:id])
    @sport_center.destroy

    respond_to do |format|
      format.html { redirect_to sport_centers_url }
      format.json { head :no_content }
    end
  end
end
