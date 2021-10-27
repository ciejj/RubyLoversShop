# frozen_string_literal: true

module Products
  class FilterProducts

    def initialize(scope = Product.all.with_attached_main_image)
      @scope = scope
    end

    def call(params)
      @scope = filter_by_brand(params[:brand_id])
      filter_by_category(params[:category_id])
    end

    private

    def filter_by_brand(brand_id)
      brand_id ? @scope.where(brand_id: brand_id) : @scope
    end

    def filter_by_category(category_id)
      category_id ? @scope.where(category_id: category_id) : @scope
    end
  end
end
