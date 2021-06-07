# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Portal Main Page
  # https://user-images.githubusercontent.com/40513035/114158371-74cf4d00-98d9-11eb-96ba-c4384ecfaf03.png
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
      OnlyofficeLoggerHelper.log('Opening Portal Main Page')
      @instance.webdriver.wait_until do
        document_module_visible?
      end
    end

    def document_module_visible?
      documents_link_element.present?
    end

    def current_user_name
      top_user_name_element.text
    end
  end
end
