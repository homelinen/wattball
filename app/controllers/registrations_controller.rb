class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def new
    super
  end

  def create
    p "CREATE A NEW USER. yESYYESYSE"
    @user = User.new(params[:user])
    p @user.valid?

    if @user.save!
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
      redirect_to root_url
    else
      flash[:notice] = "Flip"
      render :action => :new
    end
  end
end
