# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /affiliates.aspx
  # https://user-images.githubusercontent.com/67409742/161255725-e5fb6a6b-7a77-41a5-9966-9b6553324fa6.png
  class SitePartnersAffiliates
    include PageObject
    include SiteToolbar

    element(:become_an_affiliates, xpath: '//a[@class="button become-affiliate"]')
    link(:register_an_affiliates, xpath: '//div[@class="aff-hts-btn-bl"]/a[contains(@href,"https://www.avangatenetwork.com/affiliates/sign-up")]')
    link(:sign_in_an_affiliates, xpath: '//div[@class="aff-hts-btn-bl"]/a[contains(@href,"https://store.onlyoffice.com/affiliates/")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(become_an_affiliates_element) }
    end

    def transition_to_affiliates?
      become_an_affiliates_element.click
      @instance.webdriver.switch_to_popup
      url = @instance.webdriver.get_url
      url.include?('avangatenetwork.com')
    end

    def registration_to_affiliates?
      attribute = @instance.webdriver.get_attribute(register_an_affiliates_element, 'href')
      register_an_affiliates_element.click
      @instance.webdriver.switch_to_popup
      url = @instance.webdriver.get_url
      attribute == url
    end

    def sign_in_to_affiliates?
      attribute = @instance.webdriver.get_attribute(sign_in_an_affiliates_element, 'href')
      sign_in_an_affiliates_element.click
      @instance.webdriver.switch_to_popup
      url = @instance.webdriver.get_url
      attribute == url
    end
  end
end
