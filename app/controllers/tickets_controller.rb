class TicketsController < ApplicationController
  load_and_authorize_resource

  # GET /tickets
  # GET /tickets.json
  def index

    if current_user
      if current_user.privileged?
        @tickets = Ticket.all
      else
        @tickets = Ticket.where(:user_id => current_user.id)
      end
    else
      @tickets = []
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new
    event = Event.find(params[:event])
    @ticket.start = event.start

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.json
  def create
    adult_number = params[:num][:adult]
    consession_number = params[:num][:consession]

    @ticket = Ticket.new(params[:ticket])
    @ticket.denomination = 'adult'
    (0..adult_number).each do
      respond_to do |format|
        if !@ticket.save
          format.html { render action: "new" }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      end
    end

    @ticket.denomination = 'concession'
    (0..concession_number).each do
      save_and_respond(@ticket.save)
    end

  end

  # Respond if there is a failure
  def save_and_respond(record)
    respond_to do |format|
      if !record.save
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

end
