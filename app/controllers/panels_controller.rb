class PanelsController < ApplicationController

  def admin
    authorize! :panel, :admin

    render 'admin'
  end

  def official
    authorize! :panel, :official

    render 'official'
  end
end
