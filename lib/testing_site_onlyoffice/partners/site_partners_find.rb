# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /find-partners.aspx
  # https://user-images.githubusercontent.com/67409742/162488607-64c67ef1-648f-43e1-a16e-95366bdde8c5.png
  class SitePartnersFind
    include PageObject
    include SiteToolbar

    link(:become_partner, xpath: '//div[@class="lop_top_button_block"]//a[contains(@href,"/partnership-request.aspx")]')
    link(:submit_request, xpath: '//div[@class="pjb_button_block"]//a[contains(@href,"/partnership-request.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(become_partner_element) }
    end

    def check_become_partner_request?
      become_partner_element.click
      SitePartnersRequest.new(@instance)
    end

    def check_button_submit_request?
      become_partner_element.click
      SitePartnersRequest.new(@instance)
    end
  end
end
