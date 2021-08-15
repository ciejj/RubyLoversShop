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
    possible_events = Payments::StateService.new(object).possible_events
    h.concat complete_button(possible_events)
    h.concat fail_button(possible_events)
    h.concat not_available(possible_events)
  end

  def complete_button(possible_events)
    if possible_events.include?(:complete)
      h.link_to 'Complete', h.admin_payment_path(id: object.id, event: 'complete'),
                method: :patch, class: 'btn btn-outline-success btn-sm complete-payment m-1'
    end
  end

  def fail_button(possible_events)
    if possible_events.include?(:fail)
      h.link_to 'Fail', h.admin_payment_path(id: object.id, event: 'fail'),
                method: :patch, class: 'btn btn-outline-danger btn-sm complete-payment m-1'
    end
  end

  def not_available(possible_events)
    h.tag.span('not available', class: 'text-muted') if possible_events.empty?
  end
end
