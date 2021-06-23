# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @active_filters = filters_params || { filters: '' }
    @products = Product.includes([:main_image_attachment]).all
    @products = @products.filter_by_category(@active_filters[:category]) if @active_filters[:category].present?
    @products = @products.filter_by_brand(@active_filters[:brand]) if @active_filters[:brand].present?
  end

  def filters_params
    params.permit(:category, :brand)
  end
end
