# frozen_string_literal: true

class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :payment
  decorates_association :shipment

  def brand_info
    object.brand.present? ? object.brand.name : '-'
    h.tag.p("Brand: #{object.brand.name}", class: 'product-brand')
  end
end
