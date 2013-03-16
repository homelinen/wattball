class HurdlePlayersController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb "hurdle players", :hurdle_players_path, :except => :index
  add_breadcrumb "hurdle player", :hurdle_player_path, :only => %w(edit)

  # GET /hurdle_players
  # GET /hurdle_players.json
  def index
    @hurdle_players = HurdlePlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hurdle_players }
    end
  end

  # GET /hurdle_players/1
  # GET /hurdle_players/1.json
  def show
    @hurdle_player = HurdlePlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hurdle_player }
    end
  end

  # GET /hurdle_players/new
  # GET /hurdle_players/new.json
  def new
    @hurdle_player = HurdlePlayer.new
    @hurdle_player.build_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hurdle_player }
    end
  end

  # GET /hurdle_players/1/edit
  def edit
    @hurdle_player = HurdlePlayer.find(params[:id])
  end

  # POST /hurdle_players
  # POST /hurdle_players.json
  def create
    @hurdle_player = HurdlePlayer.new(params[:hurdle_player])

    respond_to do |format|
      if @hurdle_player.save
        format.html { redirect_to @hurdle_player, notice: 'Hurdle player was successfully created.' }
        format.json { render json: @hurdle_player, status: :created, location: @hurdle_player }
      else
        format.html { render action: "new" }
        format.json { render json: @hurdle_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hurdle_players/1
  # PUT /hurdle_players/1.json
  def update
    @hurdle_player = HurdlePlayer.find(params[:id])

    respond_to do |format|
      if @hurdle_player.update_attributes(params[:hurdle_player])
        format.html { redirect_to @hurdle_player, notice: 'Hurdle player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hurdle_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hurdle_players/1
  # DELETE /hurdle_players/1.json
  def destroy
    @hurdle_player = HurdlePlayer.find(params[:id])
    @hurdle_player.destroy

    respond_to do |format|
      format.html { redirect_to hurdle_players_url }
      format.json { head :no_content }
    end
  end
end
