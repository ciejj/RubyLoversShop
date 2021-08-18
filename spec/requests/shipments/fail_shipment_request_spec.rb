# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH admin/shipments/:id?event=fail', type: :request do
  let!(:order) { create(:order) }
  let!(:shipment) { order.shipment }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    context 'when the shipment state is \'pending\'' do
      it 'does not change the shipment\'s state' do
        expect do
          patch "/admin/shipments/#{shipment.id}?event=fail"
          shipment.reload
        end.not_to change(shipment, :state)
      end
    end

    context 'when the shipment state is \'ready\'' do
      before do
        shipment.update(state: 'ready')
      end

      it 'sets the shipment\'s state to \'failed\'' do
        expect do
          patch "/admin/shipments/#{shipment.id}?event=fail"
          shipment.reload
        end.to change(shipment, :state).from('ready').to('failed')
      end
    end

    context 'when the shipment state is \'shipped\'' do
      before do
        shipment.update(state: 'shipped')
      end

      it 'does not change the shipment\'s state' do
        expect do
          patch "/admin/shipments/#{shipment.id}?event=fail"
          shipment.reload
        end.not_to change(shipment, :state)
      end
    end

    context 'when the shipment state is \'failed\'' do
      before do
        shipment.update(state: 'failed')
      end

      it 'does not change the shipment\'s state' do
        expect do
          patch "/admin/shipments/#{shipment.id}?event=fail"
          shipment.reload
        end.not_to change(shipment, :state)
      end
    end

    context 'when the shipment state is \'canceled\'' do
      before do
        shipment.update(state: 'canceled')
      end

      it 'does not change the shipment\'s state' do
        expect do
          patch "/admin/shipments/#{shipment.id}?event=fail"
          shipment.reload
        end.not_to change(shipment, :state)
      end
    end
  end
end
