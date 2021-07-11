class UsersController < ApplicationController
  def show
    # @user = User.find(id: params[:id])
    @user = User.find(params[:id])
    # @prototyoes = Prototype.includes(:user)
    @prototypes = @user.prototypes
  end
end
