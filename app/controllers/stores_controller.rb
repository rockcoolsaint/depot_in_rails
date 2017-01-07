class StoresController < ApplicationController
  def index
  	@products = Product.all
  	@cart = current_cart

  	@count = increment_count
  end
end
