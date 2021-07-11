class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @prototyoes = Prototype.includes(:user)
    # @prototyoes = Prototype.all
    # @user = User.find(params[:prototype_id])
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
      # redirect_to root_path(@prototype)
    else
      # @prototype = @prototype.includes(:user)
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    # @prototype = Prototype.find(params[:prototype_id] || params[:id])
    # @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new
    # @comment = Comment.new(comment_params)
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
      # redirect_to action: "show"
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
    # redirect_to action: "index"
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  # def comment_params
  #   params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  # end

  def move_to_index
    prototype = Prototype.find(params[:id])
      unless prototype.user_id == current_user.id
        redirect_to action: :index
      end
  end
end
