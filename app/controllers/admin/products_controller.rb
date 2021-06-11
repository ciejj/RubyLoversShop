module Admin
  class ProductsController < ApplicationController
    layout 'admin'
    before_action :authenticate_administrator!
  
    def index
    end
  
  end
end
