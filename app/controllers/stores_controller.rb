class StoresController < ApplicationController
  skip_before_filter :authorize
  def index
  	if params[:set_locale]
  		redirect_to store_path(locale: params[:set_locale])
  	else
  		@products = Product.all
  		@cart = current_cart
  	end

  	@count = increment_count
  end
end