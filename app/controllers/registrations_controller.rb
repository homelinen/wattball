class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def new
    super
  end

  def create
    @user = User.new(params[:user])

    @user.save

    if @user.save
      flash[:notice] = "You have signed up successfully!"
      redirect_to root_url
    else
      flash[:notice] = "Flip"
      render :action => :new
    end
  end
end
