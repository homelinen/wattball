class HurdleMatchesController < ApplicationController
  # GET /hurdle_matches
  # GET /hurdle_matches.json
  def index
    @hurdle_matches = HurdleMatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hurdle_matches }
    end
  end

  # GET /hurdle_matches/1
  # GET /hurdle_matches/1.json
  def show
    @hurdle_match = HurdleMatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hurdle_match }
    end
  end

  # GET /hurdle_matches/1/edit
  def edit
    @hurdle_match = HurdleMatch.find(params[:id])
  end

  # POST /hurdle_matches
  # POST /hurdle_matches.json
  def create
    @hurdle_match = HurdleMatch.new(params[:hurdle_match])

    respond_to do |format|
      if @hurdle_match.save
        format.html { redirect_to @hurdle_match, notice: 'Hurdle match was successfully created.' }
        format.json { render json: @hurdle_match, status: :created, location: @hurdle_match }
      else
        format.html { render action: "new" }
        format.json { render json: @hurdle_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hurdle_matches/1
  # PUT /hurdle_matches/1.json
  def update
    @hurdle_match = HurdleMatch.find(params[:id])

    respond_to do |format|
      if @hurdle_match.update_attributes(params[:hurdle_match])
        format.html { redirect_to @hurdle_match, notice: 'Hurdle match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hurdle_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hurdle_matches/1
  # DELETE /hurdle_matches/1.json
  def destroy
    @hurdle_match = HurdleMatch.find(params[:id])
    @hurdle_match.destroy

    respond_to do |format|
      format.html { redirect_to hurdle_matches_url }
      format.json { head :no_content }
    end
  end
end
