# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :payment
  decorates_association :shipment

  def state_badge
    case object.state
    when 'new'
      helpers.tag.span('new', class: 'order-state badge badge-secondary')
    when 'completed'
      helpers.tag.span('completed', class: 'order-state badge badge-success')
    when 'failed'
      helpers.tag.span('failed', class: 'order-state badge badge-danger')
    end
  end

  def events_buttons
    permitted_events = Orders::StateService.new(object).permitted_events
    %w[complete fail].each do |event|
      h.concat method("#{event}_button").call(permitted_events)
    end
    h.concat not_available(permitted_events)
  end

  def complete_button(permitted_events)
    if permitted_events.include?(:complete)
      h.link_to 'Complete', h.admin_order_path(id: object.id, event: 'complete'),
                method: :patch, class: 'btn btn-outline-success btn-sm complete-payment m-1'
    end
  end

  def fail_button(permitted_events)
    if permitted_events.include?(:fail)
      h.link_to 'Fail', h.admin_order_path(id: object.id, event: 'fail'),
                method: :patch, class: 'btn btn-outline-danger btn-sm complete-payment m-1'
    end
  end

  def not_available(permitted_events)
    h.tag.span('not available', class: 'text-muted') if permitted_events.empty?
  end
end
