# frozen_string_literal: true

class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :brand

  def main_image_path
    object.main_image.attached? ? object.main_image : 'main_image_placeholder.png'
  end
end
