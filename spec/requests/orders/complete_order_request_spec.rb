# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared/request_not_completing_order'
require_relative '../shared/administrators_request'

RSpec.describe 'PATCH admin/orders/:id?event=complete', type: :request do
  let!(:order) { create(:order) }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    %w[pending failed completed].each do |payment_state|
      %w[pending ready cancelled failed].each do |shipment_state|
        it_behaves_like 'Request not completing order', payment_state, shipment_state
      end
    end

    context 'when the payment is \'completed\' and shipment is \'shipped\'' do
      before do
        order.payment.update(state: 'completed')
        order.shipment.update(state: 'shipped')
      end

      it 'sets the order\'s state to \'complete\'' do
        expect do
          patch "/admin/orders/#{order.id}?event=complete"
          order.reload
        end.to change(order, :state).from('new').to('completed')
      end
    end
  end

  it_behaves_like 'administrators request' do
    let(:request_method) { 'patch' }
    let(:path) { "/admin/orders/#{order.id}?event=complete" }
    let(:params) { {} }
  end
end
