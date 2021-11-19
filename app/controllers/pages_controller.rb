# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @products = Products::FilterProducts.new.call(filters_params)
    @products = @products.decorate
  end

  def filters_params
    params.permit(:category_id, :brand_id, price_range_ids: [])
  end
end
