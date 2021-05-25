# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @products = Product.all
    @products = @products.filter_by_category(params[:category]) if params[:category].present?
  end
end
