# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /education.aspx
  # https://user-images.githubusercontent.com/38238032/196981085-22c45d49-a9d1-4159-936a-c59f3f3284fc.png
  class SiteForBusinessEducation
    include PageObject
    include SiteToolbar

    button(:explore_all_features_button, xpath: '//a[contains(@class, "button default")]')
    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(explore_all_features_button_element)
      end
    end
  end
end
