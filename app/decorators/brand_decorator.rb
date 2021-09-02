# frozen_string_literal: true

class BrandDecorator < Draper::Decorator
  delegate_all

  def brand_name
    brand_name = object.present? ? object.name : '-'
    "Brand: #{brand_name}"
  end
end
