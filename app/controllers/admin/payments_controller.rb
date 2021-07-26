# frozen_string_literal: true

module Admin
  class PaymentsController < AdminController
    def complete
      flash[:notice] = 'COMPLETE'
    end

    def fail
      flash[:alert] = 'FAIL'
    end
  end
end
