# frozen_string_literal: true

module Products
  class FilterProducts
    def call(params)
      scoped = Product.all.with_attached_main_image
      scoped = filter_by_brand(scoped, params[:brand_id])
      filter_by_category(scoped, params[:category_id])
    end

    private

    def filter_by_brand(scoped, brand_id)
      brand_id ? scoped.where(brand_id: brand_id) : scoped
    end

    def filter_by_category(scoped, category_id)
      category_id ? scoped.where(category_id: category_id) : scoped
    end
  end
end
