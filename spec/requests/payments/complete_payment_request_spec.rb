# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared/administrators_request'

RSpec.describe 'PATCH admin/payments/:id?event=complete', type: :request do
  let!(:order) { create(:order) }
  let!(:payment) { order.payment }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    context 'when the payment state is \'pending\'' do
      it 'sets the payment state to \'complete\'' do
        expect do
          patch "/admin/payments/#{payment.id}?event=complete"
          payment.reload
        end.to change(payment, :state).from('pending').to('completed')
      end
    end

    context 'when the payment state is \'complete\'' do
      before do
        payment.update(state: 'completed')
      end

      it 'does not change the payment state' do
        expect do
          patch "/admin/payments/#{payment.id}?event=complete"
          payment.reload
        end.not_to change(payment, :state)
      end
    end

    context 'when the payment state is \'failed\'' do
      before do
        payment.update(state: 'failed')
      end

      it 'does not change the payment state' do
        expect do
          patch "/admin/payments/#{payment.id}?event=complete"
          payment.reload
        end.not_to change(payment, :state)
      end
    end
  end

  it_behaves_like 'administrators request' do
    let(:request_method) { 'patch' }
    let(:path) { "/admin/payments/#{payment.id}?event=complete" }
  end
end
