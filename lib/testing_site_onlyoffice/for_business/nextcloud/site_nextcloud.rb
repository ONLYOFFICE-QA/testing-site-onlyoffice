# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-nextcloud.aspx
  # https://user-images.githubusercontent.com/67409742/163774909-8621c72c-9762-4a22-8fd0-d29dff5fd10b.png
  class SiteNextcloud < SiteForBusiness
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Nextcloud')
    end

    def check_link_get_it_now
      @instance.webdriver.click_on_locator('//div[@class="connector_top"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]', true)
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def check_link_download_for_desktop
      @instance.webdriver.click_on_locator('//a[contains(@href,"/apps.aspx")]', true)
      SiteFeaturesDesktop.new(@instance)
    end

    def check_link_get_onlyoffice_now
      @instance.webdriver.click_on_locator('//div[@id="goonbtn"]//a[contains(@href,"/download-docs.aspx?from=officefornextcloud")]', true)
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end
  end
end
