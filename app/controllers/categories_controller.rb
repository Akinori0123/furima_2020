class CategoriesController < ApplicationController
  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @items = Item.order(created_at: :desc)
  end
end
