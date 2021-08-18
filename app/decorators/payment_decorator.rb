# frozen_string_literal: true

class PaymentDecorator < Draper::Decorator
  delegate_all

  def state_badge
    case object.state
    when 'pending'
      h.tag.span('pending', class: 'payment-state badge badge-secondary')
    when 'completed'
      h.tag.span('completed', class: 'payment-state badge badge-success')
    when 'failed'
      h.tag.span('failed', class: 'payment-state badge badge-danger')
    end
  end

  def events_buttons
    permitted_events = Payments::StateService.new(object).permitted_events
    %w[complete fail].each do |event|
      h.concat method("#{event}_button").call if permitted_events.include?(event.to_sym)
    end
    h.concat not_available if permitted_events.empty?
  end

  def complete_button
    h.link_to 'Complete', h.admin_payment_path(id: object.id, event: 'complete'),
              method: :patch, class: 'btn btn-outline-success btn-sm complete-payment m-1'
  end

  def fail_button
    h.link_to 'Fail', h.admin_payment_path(id: object.id, event: 'fail'),
              method: :patch, class: 'btn btn-outline-danger btn-sm complete-payment m-1'
  end

  def not_available
    h.tag.span('not available', class: 'text-muted')
  end
end
