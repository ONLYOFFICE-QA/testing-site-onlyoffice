# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Personal main page
  # https://user-images.githubusercontent.com/40513035/113815572-3e060500-9728-11eb-84ea-bc9cd885b0f9.png
  class PersonalMainPage
    include PageObject

    link(:login, xpath: '//*[@id="personalLogin"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      @instance.webdriver.wait_until do
        login_visible?
      end
    end

    def login_visible?
      login_element.present?
    end
  end
end
