# frozen_string_literal: true

class ShipmentDecorator < Draper::Decorator
  delegate_all

  def state_badge
    case object.state
    when 'pending'
      css_class = 'shipment-state badge badge-secondary'
    when 'ready', 'shipped'
      css_class = 'shipment-state badge badge-success'
    when 'canceled', 'failed'
      css_class = 'shipment-state badge badge-danger'
    end
    h.tag.span(object.state, class: css_class)
  end

  def events_buttons
    possible_events = Shipments::StateService.new(object).possible_events
    %w[prepare ship cancel fail].each do |event|
      h.concat method("#{event}_button").call(possible_events)
    end
    h.concat not_available(possible_events)
  end

  def prepare_button(possible_events)
    if possible_events.include?(:prepare)
      h.link_to 'Prepare', h.admin_shipment_path(id: object.id, event: 'prepare'),
                method: :patch, class: 'btn btn-outline-dark btn-sm prepare-shipment m-1'
    end
  end

  def ship_button(possible_events)
    if possible_events.include?(:ship)
      h.link_to 'Ship', h.admin_shipment_path(id: object.id, event: 'ship'),
                method: :patch, class: 'btn btn-outline-success btn-sm ship-shipment m-1'
    end
  end

  def fail_button(possible_events)
    if possible_events.include?(:fail)
      h.link_to 'Fail', h.admin_shipment_path(id: object.id, event: 'fail'),
                method: :patch, class: 'btn btn-outline-danger btn-sm fail-shipment m-1'
    end
  end

  def cancel_button(possible_events)
    if possible_events.include?(:cancel)
      h.link_to 'Cancel', h.admin_shipment_path(id: object.id, event: 'cancel'),
                method: :patch, class: 'btn btn-outline-danger btn-sm cancel-shipment m-1'
    end
  end

  def not_available(possible_events)
    h.tag.span('not available', class: 'text-muted') if possible_events.empty?
  end
end
