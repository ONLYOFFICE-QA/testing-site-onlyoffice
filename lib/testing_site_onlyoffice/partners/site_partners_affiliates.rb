# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /affiliates.aspx
  # https://user-images.githubusercontent.com/67409742/161255725-e5fb6a6b-7a77-41a5-9966-9b6553324fa6.png
  class SitePartnersAffiliates
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar

    element(:become_an_affiliates, xpath: '//a[@class="button become-affiliate"]')
    link(:register_an_affiliates, xpath: '//div[@class="aff-hts-btn-bl"]/a[contains(@href,"getrewardful.com")]')
    link(:learn_more_docspace, xpath: '//p[@class="solvefloating"]//a[contains(@href,"/docspace.aspx")]')
    link(:product_guide, xpath: '//a[contains(@href,"/images/whitepapers/pdf/onlyoffice_secure_cloud_space.pdf")]')
    link(:marketing_kit, xpath: '//a[contains(@href,"/press-downloads.aspx?from=affiliates")]')
    link(:affiliate_policy, xpath: '//a[contains(@href,"rewardful.com/terms")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(become_an_affiliates_element) }
    end

    def click_become_an_affiliates_button
      @instance.webdriver.click_on_locator(become_an_affiliates_element)
    end

    def click_registration_to_affiliates_button
      @instance.webdriver.click_on_locator(register_an_affiliates_element)
    end

    def click_learn_more_docspace
      @instance.webdriver.click_on_locator(learn_more_docspace_element)
      TestingSiteOnlyoffice::SiteDocSpaceMainPage.new(@instance)
    end

    def click_product_guide
      @instance.webdriver.click_on_locator(product_guide_element)
      @instance.webdriver.wait_file_for_download('onlyoffice_secure_cloud_space.pdf')
    end

    def click_marketing_kit
      @instance.webdriver.click_on_locator(marketing_kit_element)
      TestingSiteOnlyoffice::SiteAboutPressDownloads.new(@instance)
    end

    def click_affiliates_policy_button
      @instance.webdriver.click_on_locator(affiliate_policy_element)
    end
  end
end
