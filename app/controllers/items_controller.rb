class ItemsController < ApplicationController
  before_action :set_item, only: %i(show)

  def index
    @items = Item.all
  end

  def show
    if @item
      respond_to do |format|
        format.html
        format.json do
          render json: {
            code: @item.code
          }
        end
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:id] || params[:item_id])
  end
end
