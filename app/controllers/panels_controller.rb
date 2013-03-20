class PanelsController < ApplicationController

  def official
    authorize! :panel, :official

    render 'official'
  end
end
