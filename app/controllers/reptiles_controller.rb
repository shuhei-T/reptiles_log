class ReptilesController < ApplicationController
  before_action :set_reptile, only: %i[show edit update destroy]
  before_action :params_modifi, only: %i[create update]

  def index
    @reptiles = current_user.reptiles.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @reptile = Reptile.new
  end

  def create
    @reptile = current_user.reptiles.build(reptile_params)
    if @reptile.save
      redirect_to reptiles_path, success: t('defaults.message.created', item: Reptile.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Reptile.model_name.human)
      render :new
    end
  end

  def show;end

  def edit;end

  def update
    if @reptile.update(reptile_params)
      redirect_to @reptile, success: t('defaults.message.updated', item: Reptile.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Reptile.model_name.human)
      render :edit
    end
  end

  def destroy
    @reptile.destroy!
    redirect_to reptiles_path, success: t('defaults.message.deleted', item: Reptile.model_name.human)
  end

  private

  def set_reptile
    @reptile = current_user.reptiles.find(params[:id])
  end

  def reptile_params
    params.require(:reptile).permit(:name, :reptile_category, :morph, :sex, :birthday, :adoptaversary, :comment, :image, :image_cache, :age)
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
