class ReptilesController < ApplicationController
  def index
    @reptiles = Reptile.all.includes(:user).order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private


  def reptile_params
    params.require(:reptile).permit(:name, :morph, :sex, :birthday, :adoptaversary, :image, :comment, :image, :age)
  end
end
