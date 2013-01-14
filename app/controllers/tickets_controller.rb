class TicketsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end
end