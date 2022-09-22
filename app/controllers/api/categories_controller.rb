class Api::CategoriesController < Api::SkipAuthenticationController
  def index
    categories = {}
    MarketCategoryMapping::CATEGORY_NAMES_MAP.each { |k, v| categories[k] = v[I18n.locale] }
    render json: { categories: categories }, status: 200
  end
end
