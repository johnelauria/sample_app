class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      sign_in @user
      flash[:success] = "Welcome #{@user.name}! Thank you for signing up to this Sample Application!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def new
  	@user = User.new

  	respond_to do |format|
  		format.html
  		format.json { render json: @user }
  	end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

  	respond_to do |format|
  		format.html
  		format.json { render json: @user}
  	end
  end

    
  def edit
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account has been successfully deleted"
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:error] = "You sir are under arrest for the violation of something"
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  end 