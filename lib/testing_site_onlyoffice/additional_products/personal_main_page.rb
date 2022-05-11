# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Personal main page
  # https://user-images.githubusercontent.com/67409742/167831504-14649f45-7ad6-4e6a-b72f-1ba490c291e6.png
  class PersonalMainPage
    include PageObject

    link(:login, xpath: '//a[contains(@href,"/sign-in")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      @instance.webdriver.wait_until do
        login_visible?
      end
    end

    def login_visible?
      @instance.webdriver.element_present?(login_element)
    end
  end
end
