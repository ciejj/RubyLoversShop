class Admin::ProductsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
  end

end
