# frozen_string_literal: true

class ShipmentDecorator < Draper::Decorator
  delegate_all

  def state_badge
    case object.state
    when 'pending'
      badge_class = 'shipment-state badge badge-secondary'
    when 'ready', 'shipped'
      badge_class = 'shipment-state badge badge-success'
    when 'canceled', 'failed'
      badge_class = 'shipment-state badge badge-danger'
    end
    h.tag.span(object.state, class: badge_class)
  end

  def events_buttons
    if permitted_events.empty?
      h.concat not_available
    else
      %w[prepare ship cancel fail].each do |event|
        h.concat method("#{event}_button").call if permitted_events.include?(event.to_sym)
      end
    end
  end

  def permitted_events
    @permitted_events = Shipments::StateService.new(object).permitted_events
  end

  def prepare_button
    h.link_to 'Prepare', h.admin_shipment_path(id: object.id, event: 'prepare'),
              method: :patch, class: 'btn btn-outline-dark btn-sm prepare-shipment m-1'
  end

  def ship_button
    h.link_to 'Ship', h.admin_shipment_path(id: object.id, event: 'ship'),
              method: :patch, class: 'btn btn-outline-success btn-sm ship-shipment m-1'
  end

  def fail_button
    h.link_to 'Fail', h.admin_shipment_path(id: object.id, event: 'fail'),
              method: :patch, class: 'btn btn-outline-danger btn-sm fail-shipment m-1'
  end

  def cancel_button
    h.link_to 'Cancel', h.admin_shipment_path(id: object.id, event: 'cancel'),
              method: :patch, class: 'btn btn-outline-danger btn-sm cancel-shipment m-1'
  end

  def not_available
    h.tag.span('not available', class: 'text-muted')
  end
end
