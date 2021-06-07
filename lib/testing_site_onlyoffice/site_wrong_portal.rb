# frozen_string_literal: true

require_relative 'modules/site_toolbar'

module TestingSiteOnlyoffice
  # Wrong portal name
  # https://user-images.githubusercontent.com/40513035/102991038-798a1400-4529-11eb-8eb2-75fb5ccf8c4d.png
  class SiteWrongPortal
    include PageObject
    include SiteToolbar

    text_field(:email, xpath: '//*[@id="PortalNameRestoreInput"]')
    text_field(:recover, xpath: '//*[@id="PortalNameRestoreFinishButton"]')
    span(:success_message, xpath: '//*[@id="PortalNameRestoreSuccessMessage"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { email_element.present? }
    end

    def recover_address_portal(email)
      self.email = email
      recover_element.click
      @instance.webdriver.wait_until { success_message_element.present? }
    end
  end
end
