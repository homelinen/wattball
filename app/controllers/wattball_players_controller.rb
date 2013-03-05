class WattballPlayersController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb "wattball_players", :wattball_players_path
  add_breadcrumb "wattball_player", :wattball_player_path, :only => %w(edit)

  # GET /wattball_players
  # GET /wattball_players.json
  def index
    @wattball_players = WattballPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wattball_players }
    end
  end

  # GET /wattball_players/1
  # GET /wattball_players/1.json
  def show
    @wattball_player = WattballPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wattball_player }
    end
  end

  # GET /wattball_players/new
  # GET /wattball_players/new.json
  def new
    @wattball_player = WattballPlayer.new
    @wattball_player.build_user
    @wattball_player.build_contact

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wattball_player }
    end
  end

  # GET /wattball_players/1/edit
  def edit
    @wattball_player = WattballPlayer.find(params[:id])
  end

  # POST /wattball_players
  # POST /wattball_players.json
  def create
    @wattball_player = WattballPlayer.new(params[:wattball_player])

    respond_to do |format|
      if @wattball_player.save
        format.html { redirect_to @wattball_player, notice: 'Wattball player was successfully created.' }
        format.json { render json: @wattball_player, status: :created, location: @wattball_player }
      else
        format.html { render action: "new" }
        format.json { render json: @wattball_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wattball_players/1
  # PUT /wattball_players/1.json
  def update
    @wattball_player = WattballPlayer.find(params[:id])

    respond_to do |format|
      if @wattball_player.update_attributes(params[:wattball_player])
        format.html { redirect_to @wattball_player, notice: 'Wattball player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wattball_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wattball_players/1
  # DELETE /wattball_players/1.json
  def destroy
    @wattball_player = WattballPlayer.find(params[:id])
    @wattball_player.destroy

    respond_to do |format|
      format.html { redirect_to wattball_players_url }
      format.json { head :no_content }
    end
  end
end
