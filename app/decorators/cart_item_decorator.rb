# frozen_string_literal: true

class CartItemDecorator < Draper::Decorator
  delegate_all

  def image
    h.image_tag(product.main_image_path, class: 'card-img-top', style: 'width: 140px; height: 80px')
  end

  def subtotal
    product.price * object.quantity
  end

  def product
    @product || object.product.decorate
  end

  def quantity_form
    h.render partial: 'cart_items/quantity_form', locals: { cart_item: object }
  end
end
