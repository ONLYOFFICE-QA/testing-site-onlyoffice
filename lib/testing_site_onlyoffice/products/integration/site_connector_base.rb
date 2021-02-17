# Module with base elements of connectors

module TestingSiteOnlyoffice
  module SiteConnectorBase
    def initialize(instance, connector_type)
      super(instance.webdriver.driver)
      @type = connector_type
      @instance = instance
      @identifier = body_element(xpath: "//body[@id='#{@type}page']")
      @get_it_now = link_element(xpath: '//article//a[contains(@href,"connectors-request")]')
      @enterprise_edition_free = link_element(xpath: "//div[contains(@class, 'enterprise')]//a[contains(@href, '?from=officefor#{@type.downcase}')]")
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @identifier.present? && @get_it_now.present?
      end
    end

    def click_get_it_now
      @instance.webdriver.click_on_locator(@get_it_now.selector[:xpath])
      @instance.webdriver.switch_to_popup
      SiteConnectorsRequest.new(@instance)
    end

    def go_to_enterprise_edition_free
      @instance.webdriver.click_on_locator(@enterprise_edition_free.selector[:xpath])
      @instance.webdriver.switch_to_popup
      SiteConnectorsRequest.new(@instance)
    end
  end
end
