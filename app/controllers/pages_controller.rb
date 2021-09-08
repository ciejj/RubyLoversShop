# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :initialize_cart

  def home
    @active_filters = filters_params || { filters: '' }
    @products = Product.all.with_attached_main_image
    @products = @products.filter_by_category(@active_filters[:category]) if @active_filters[:category].present?
    @products = @products.filter_by_brand(@active_filters[:brand]) if @active_filters[:brand].present?
    @products = @products.decorate
  end

  def filters_params
    params.permit(:category, :brand)
  end
end
