# https://teamlab-hourly-check-eu.onlyoffice.eu/ (portal root page)
# https://cloud.githubusercontent.com/assets/18173785/20660339/303c979a-b55a-11e6-9930-a3a8e2e7e53b.png

class PortalMainPage
  attr_accessor :instance

  include PageObject

  # main menu
  main_page_products = "//div[contains(@class,'default')]"
  span(:top_user_name, xpath: '//span[contains(@class, "usr-prof")]')
  link(:documents_link, xpath: "#{main_page_products}/a[contains(@href, 'Products/Files')]")

  def initialize(instance)
    super(instance.webdriver.driver)
    @instance = instance
    wait_to_load
  end

  def wait_to_load
    OnlyofficeLoggerHelper.log('Opening Main Page')
    @instance.webdriver.wait_until do
      document_module_visible?
    end
  end

  # visibility
  def document_module_visible?
    documents_link_element.present?
  end

  def current_user_name
    top_user_name_element.text
  end
end
