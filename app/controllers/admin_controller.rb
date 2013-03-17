class AdminController < ApplicationController
  load_and_authorize_resource :staff, :parent => false

  def index
    render # index.html.erb
  end
end
