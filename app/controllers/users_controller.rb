class UsersController < ApplicationController

  def create
  	@user = User.new(params[:user])

  	if @user.save
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

  	respond_to do |format|
  		format.html
  		format.json { render json: @user}
  	end
  end
end
