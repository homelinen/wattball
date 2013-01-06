class WattballMatchesController < ApplicationController
  # GET /wattball_matches
  # GET /wattball_matches.json
  def index
    @wattball_matches = WattballMatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wattball_matches }
    end
  end

  # GET /wattball_matches/1
  # GET /wattball_matches/1.json
  def show
    @wattball_match = WattballMatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wattball_match }
    end
  end

  # GET /wattball_matches/new
  # GET /wattball_matches/new.json
  def new
    @wattball_match = WattballMatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wattball_match }
    end
  end

  # GET /wattball_matches/1/edit
  def edit
    @wattball_match = WattballMatch.find(params[:id])
  end

  # POST /wattball_matches
  # POST /wattball_matches.json
  def create
    @wattball_match = WattballMatch.new(params[:wattball_match])

    respond_to do |format|
      if @wattball_match.save
        format.html { redirect_to @wattball_match, notice: 'Wattball match was successfully created.' }
        format.json { render json: @wattball_match, status: :created, location: @wattball_match }
      else
        format.html { render action: "new" }
        format.json { render json: @wattball_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wattball_matches/1
  # PUT /wattball_matches/1.json
  def update
    @wattball_match = WattballMatch.find(params[:id])

    respond_to do |format|
      if @wattball_match.update_attributes(params[:wattball_match])
        format.html { redirect_to @wattball_match, notice: 'Wattball match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wattball_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wattball_matches/1
  # DELETE /wattball_matches/1.json
  def destroy
    @wattball_match = WattballMatch.find(params[:id])
    @wattball_match.destroy

    respond_to do |format|
      format.html { redirect_to wattball_matches_url }
      format.json { head :no_content }
    end
  end
end
