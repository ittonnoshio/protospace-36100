class CommentsController < ApplicationController
  def create
    # binding.pry
    # @comment = Comment.new(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype.id}"
      # redirect_to prototype_path(@prototype)
      
      # redirect_to prototype_path(@prototype.id)
      # redirect_to prototype_path
      # redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
