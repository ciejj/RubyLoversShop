module Admin
  class ProductsController < ApplicationController
    layout 'admin'
    before_action :authenticate_administrator!

    def index
      @products = Product.includes([:category]).includes([:brand]).all
    end

  end
end
