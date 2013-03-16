class TeamsController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb "teams", :teams_path
  add_breadcrumb "team", :team_path, :only => %w(show edit)

  # GET /teams
  # GET /teams.json
  def index
    
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show

    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    add_breadcrumb "new", :new_team_path
    #@team.User.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    add_breadcrumb "edit", :edit_team_path
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    user_attrs = params[:team].delete(:user_attributes)
    user = User.new(user_attrs)
    if !user.save!
      flash[:error] = user.errors
      redirect_to new
    end

    @team = Team.new(params[:team])

    @team.user = user
    @team.user_id = user.id

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
