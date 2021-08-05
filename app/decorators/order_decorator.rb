# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :payment

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
end
