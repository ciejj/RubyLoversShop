# frozen_string_literal: true

class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :payment
  decorates_association :shipment

  def brand_info
    brand_name = object.brand.present? ? object.brand.name : '-'
    "Brand: #{brand_name}"
  end
end
