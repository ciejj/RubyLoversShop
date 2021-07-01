module Admin
  class AdminController < ApplicationController
    before_action :administrator_authentication

    def administrator_authentication
      unless administrator_signed_in?
        flash[:alert] = 'You are not authorized.'
        redirect_to root_path
      end
    end
  end
end
