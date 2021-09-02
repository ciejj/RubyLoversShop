# frozen_string_literal: true

class ProductDecorator < Draper::Decorator
  delegate_all
  decorates_association :brand

  def main_image_path
    main_image = object.main_image
    main_image.attached? ? main_image : 'main_image_placeholder.png'
  end

  def add_to_cart_button
    if h.user_signed_in?
      h.link_to 'Add to Cart', h.add_to_cart_path(product_id: object.id),
                class: 'btn btn-small btn-block btn-outline-secondary'
    end
  end
end
