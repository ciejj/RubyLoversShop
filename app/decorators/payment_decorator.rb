# frozen_string_literal: true

class PaymentDecorator < Draper::Decorator
  delegate_all

  def state_badge
    case object.state
    when 'pending'
      badge_class = 'payment-state badge badge-secondary'
    when 'completed'
      badge_class = 'payment-state badge badge-success'
    when 'failed'
      badge_class = 'payment-state badge badge-danger'
    end
    h.tag.span(object.state, class: badge_class)
  end

  def events_buttons
    if permitted_events.empty?
      h.concat not_available
    else
      %w[complete fail].each do |event|
        h.concat method("#{event}_button").call if permitted_events.include?(event.to_sym)
      end
    end
  end

  def permitted_events
    @permitted_events ||= Payments::StateService.new(object).permitted_events
  end

  def complete_button
    h.link_to 'Complete', h.admin_payment_path(id: object.id, event: 'complete'),
              method: :patch, class: 'btn btn-outline-success btn-sm complete-payment m-1'
  end

  def fail_button
    h.link_to 'Fail', h.admin_payment_path(id: object.id, event: 'fail'),
              method: :patch, class: 'btn btn-outline-danger btn-sm fail-payment m-1'
  end

  def not_available
    h.tag.span('not available', class: 'text-muted')
  end
end
