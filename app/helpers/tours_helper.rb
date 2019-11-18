module ToursHelper
  def full_title page_title
    base_title = I18n.t "base_title"
    return base_title if page_title.blank?

    page_title + " | " + base_title
  end
end
