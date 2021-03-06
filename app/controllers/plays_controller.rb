class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  before_action :find_categories, only: [:new, :create, :edit, :update]

  def index
    if params[:format].blank?
      @plays = Play.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:format]).id
      @plays = Play.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)
    if params[:category_id].present?
      @play.category_id = params[:category_id]
    end

    if @play.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  def update
    @play.category_id = params[:category_id]

    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render :edit
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id, :play_img)
  end

  def find_play
    @play = Play.find(params[:id])
  end

  def find_categories
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

end
