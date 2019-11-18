module CategoriesHelper
  def cate_select
    @categories.map{|cate| [t("nav.#{cate.name}"), cate.id]}
  end
end
