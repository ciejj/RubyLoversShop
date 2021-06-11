module Admin
  class ProductsController < ApplicationController
    layout 'admin'
    before_action :authenticate_administrator!

    def index
      @products = Product.all
    end

  end
end
