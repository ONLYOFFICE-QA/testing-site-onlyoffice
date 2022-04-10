# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /resellers.aspx
  # https://user-images.githubusercontent.com/67409742/162407146-27c796fa-91a1-49bc-8169-d1b01b077747.png
  class SitePartnersResellers
    include PageObject
    include SiteToolbar

    link(:become_partner, xpath: '//div[@class="ds-first-screen-right-img"]//a[contains(@href,"/partnership-request.aspx")]')
    link(:about_docs, xpath: '//div[@class="ds-one-of-two bg-light-gray"]//a[contains(@href,"/office-suite.aspx")]')
    link(:about_workspace, xpath: '//div[@class="ds-one-of-two bg-mid-gray"]//a[contains(@href,"/workspace.aspx")]')
    link(:translations, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/tipstricks")]')
    link(:submit_request, xpath: '//div[@class="ds-layer-div ds-contact-us-block"]//a[contains(@href,"/partnership-request.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(become_partner_element) }
    end

    def send_become_partner_request
      become_partner_element.click
      SitePartnersRequest.new(@instance)
    end

    def check_about_docs?
      about_docs_element.click
      SiteProductsDocs.new(@instance)
    end

    def check_about_workspace?
      about_workspace_element.click
      SiteProductsWorkspace.new(@instance)
    end

    def check_translations?
      attribute = @instance.webdriver.get_attribute(translations_element, 'href')
      translations_element.click
      @instance.webdriver.switch_to_popup
      current_url = URI(@instance.webdriver.get_url)
      current_url.fragment = current_url.query = nil
      parse_url = current_url.to_s
      attribute.include?(parse_url)
    end

    def check_button_submit_request?
      become_partner_element.click
      SitePartnersRequest.new(@instance)
    end
  end
end
