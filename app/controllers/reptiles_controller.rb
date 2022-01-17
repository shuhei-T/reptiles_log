class ReptilesController < ApplicationController
  before_action :params_modifi, only: [:create, :update]

  def index
    @reptiles = Reptile.all.includes(:user).order(created_at: :desc)
  end

  def new
    @reptile = Reptile.new
  end

  def create
    # binding.pry
    @reptile = current_user.reptiles.build(reptile_params)
    if @reptile.save
      redirect_to reptiles_path, success: t('defaults.message.created', item: Reptile.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Reptile.model_name.human)
      render :new
    end
  end

  def show
    @reptile = Reptile.find(params[:id])
  end

  def edit
    @reptile = current_user.reptiles.find(params[:id])
  end

  def update
    @reptile = current_user.reptiles.find(params[:id])
    if @reptile.update(reptile_params)
      redirect_to @reptile, success: t('defaults.message.updated', item: Reptile.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Reptile.model_name.human)
      render :edit
    end
  end

  def destroy
    @reptile = current_user.reptiles.find(params[:id])
    @reptile.destroy!
    redirect_to reptiles_path, success: t('defaults.message.deleted', item: Reptile.model_name.human)
  end

  private


  def reptile_params
    params.require(:reptile).permit(:name, :morph, :sex, :birthday, :adoptaversary, :comment, :image, :image_cache, :age)
  end

  def params_modifi
    params[:reptile][:birthday] = date_join(params[:birthday])
    params[:reptile][:adoptaversary] = date_join(params[:adoptaversary])
  end

  def date_join(date)
    date.values.map { |value| return if value.empty? }
    Date.new date.values[0].to_i, date.values[1].to_i, date.values[2].to_i
  end
end
