class SubsController < ApplicationController
  before_action :is_logged_in?


  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end

  def owned_post
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.user_id
      flash[:errors] = ['You cant edit someone elses sub']
      redirect_to sub_url(@sub.id)
    end
  end
end
