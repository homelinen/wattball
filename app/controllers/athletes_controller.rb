class AthletesController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb "athletes", :athletes_path
  add_breadcrumb "athlete", :athlete_path, :only => %w(edit)

  # GET /athletes
  # GET /athletes.json
  def index
    @wattballPlayers = WattballPlayer.all
    @hurdlePlayers = HurdlePlayer.all

    respond_to do |format|
      format.html # index.html.erb

      # No clue if this will work
      # Probably want a hash, really
      format.json { render json: [@wattballplayers, @hurdleplayers] }
    end
  end

  # GET /athletes/1
  # GET /athletes/1.json
  def show
    @athlete = Athlete.find(params[:id])

    if @athlete.type == WattballPlayer.to_s
      
      # Print the team name, could just say "team"
      add_breadcrumb @athlete.team.teamName, team_path(@athlete.team)
    end

    # What if the name doesn't have P in it?
    add_breadcrumb @athlete.type.split("P").join(" P").downcase, :athlete_path, :only => %w(new edit)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @athlete }
    end
  end

  # GET /athletes/new
  # GET /athletes/new.json
  def new
    respond_to format.html # new.html.erb
  end

  # GET /atheletes/new_wattball_player
  def new_wattball_player

    # Should the non-required fields be set here?
    @athlete = WattballPlayer.new
    @athlete.build_user
    @athlete.build_contact

    respond_to do |format|
      format.html { render "newWattballPlayer" }
      format.json { render json: @player }
    end
  end

  # GET /atheletes/new_wattball_player
  def new_wattball_player

    # Should the non-required fields be set here?
    @athlete = WattballPlayer.new
    @athlete.build_user
    @athlete.build_contact

    respond_to do |format|
      format.html { render "newWattballPlayer" }
      format.json { render json: @player }
    end
  end

  # GET /atheletes/new_wattball_player
  def new_hurdle_player

    # Should the non-required fields be set here?
    @athlete = HurdlePlayer.new
    @athlete.build_user

    respond_to do |format|
      format.html { render "newHurdlePlayer" }
      format.json { render json: @player }
    end
  end

  # POST /atheles/creete_wattball_player
  def create_wattball_player
    @player = Athlete.new
    respond_to do |format|
      if @athlete.save
        format.html { redirect_to @athlete, notice: 'Athlete was successfully created.' }
        format.json { render json: @athlete, status: :created, location: @athlete }
      else
        format.html { render action: "new" }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /athletes/1/edit
  def edit
    @athlete = Athlete.find(params[:id])
  end

  # POST /athletes
  # POST /athletes.json
  def create
 
    @athlete = Object.const_get(params[:athlete][:type]).new(params[:athlete])

    respond_to do |format|
      if @athlete.save
        format.html { redirect_to @athlete, notice: 'Athlete was successfully created.' }
        format.json { render json: @athlete, status: :created, location: @athlete }
      else
        format.html { render action: "new" }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /athletes/1
  # PUT /athletes/1.json
  def update
    @athlete = Athlete.find(params[:id])

    respond_to do |format|
      if @athlete.update_attributes(params[:athlete])
        format.html { redirect_to @athlete, notice: 'Athlete was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1
  # DELETE /athletes/1.json
  def destroy
    @athlete = Athlete.find(params[:id])
    @athlete.destroy

    respond_to do |format|
      format.html { redirect_to athletes_url }
      format.json { head :no_content }
    end
  end
end
