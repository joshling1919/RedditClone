class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = ["Invalid Comment"]
      redirect_to post_url(@comment.post)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = ['Invalid Comment']
      redirect_to post_url(@comment.post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_url(@comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :comment_id)
  end
end
