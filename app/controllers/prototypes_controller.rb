class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :destroy]

  def index
    @users = User.all
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end
  
  def update
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      redirect_to edit_prototype_path
    end
  end

  def destroy
    @prototype.destroy
    redirect_to(prototypes_path)
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def ensure_correct_user
    @prototype = Prototype.find(params[:id])
    if @prototype.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
