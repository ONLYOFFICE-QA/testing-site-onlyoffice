# frozen_string_literal: true

module TestingSiteOnlyoffice
  class AvangateConfirmationPage
    attr_accessor :instance

    include PageObject

    link(:avangate_finish_button_link, xpath: "//*[@id='Finish']")
    link(:avangate_auth_button_link, xpath: "//*[@id='AuthorizeButton']")
    link(:avangate_order__autorenewal_link, xpath: "//*[@id='order__autorenewal']")
    link(:avangate_img_capcha_link, xpath: "//*[@id='img_capcha']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        a = avangate_finish_button_visible
        b = avangate_auth_button_visible
        a || b
      end
      avangate_order__autorenewal_link
      sleep 5 while capcha_avangate_visible
    end

    def capcha_avangate_visible
      avangate_img_capcha_link_element.present?
    end

    def avangate_auth_button_visible
      avangate_auth_button_link_element.present?
    end

    def avangate_finish_button_visible
      avangate_finish_button_link_element.present?
    end

    def full_confirm_order(portal)
      avangate_finish_button_link if avangate_finish_button_visible
      avangate_auth_button_link if avangate_auth_button_visible
      AvangateFinishOrder.new(@instance)
      @instance.webdriver.open(portal)
      MainPage.new(@instance)
    end
  end
end
