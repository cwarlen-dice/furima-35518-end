class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_one_item, only: %i[edit update destroy]
  before_action :check_sold_user, only: %i[edit update destroy]
  before_action :set_item_includes, only: %i[show index]

  def index
    @items = @item_in_other.all.order(created_at: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to(root_path)
    else
      render :new
    end
  end

  def show
    @item = @item_in_other.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to(item_path(params[:id]))
    else
      render :edit
    end
  end

  def destroy
    redirect_to(root_path) if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_one_item
    @item = Item.find(params[:id])
  end

  def set_item_includes
    @item_in_other = Item.with_attached_image.includes(:order)
  end

  def check_sold_user
    redirect_to(root_path) unless @item.order.nil? && current_user.id == @item.user.id
  end
end
