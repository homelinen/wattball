class GalleryController < ApplicationController
  load_and_authorize_resource

  def index
      @events = Event.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @events }
      end
    end
end
