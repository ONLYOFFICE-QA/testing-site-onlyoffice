# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Try in the cloud and Run on your own server xpath for editors
  # https://user-images.githubusercontent.com/40513035/101160435-169b1080-3640-11eb-913a-3d1e80502b2b.png
  module SiteEditorsXpath
    include PageObject

    link(:docspace_registration_button, xpath: '//a[@id = "email-btn" and contains(@href, "/docspace-registration")]')
    link(:docs_get_it_now_button, xpath: '//div[@class="docs-button"]/a[contains(@href, "download.aspx#docs-enterprise")]')
  end
end
