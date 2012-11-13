class UsersController < ApplicationController

  #before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  before_filter :find_user, :only => [:show, :update, :destroy, :details]
  before_filter :checkReservations

  respond_to :json

  def show
    if !@logged_user.nil?  
      render json: @logged_user
    else
      render :status=>401
    end
  end

  def details
    if !@logged_user.nil?  
      render :json => @logged_user, :include => [:credit]
    else
      render :status=>401
    end
  end

  def create
    @user = User.new(params[:user])

      if @user.save
       render json: @user, status: :created, location: @user 
      else
       render json: @user.errors, status: :unprocessable_entity
      end
  end

  def update
    @user = @logged_user#User.find(params[:id])

      if !@logged_user.nil?  && @logged_user.update_attributes(params[:user])
        render json: @logged_user, :status=>200 
      else
        render :status=>401 #json: @user.errors, status: :unprocessable_entity 
      end
    
  end

  def destroy
    @user = User.find(params[:id])
    if @logged_user.id != @user.id
        render :status=>401, :json=>{:message=>"You can't destroy that user."}
    else
        @user.destroy
        render :status=>200
    end
  end    
end

