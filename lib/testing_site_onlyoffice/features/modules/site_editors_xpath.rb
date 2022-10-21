# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Try in the cloud and Run on your own server xpath for editors
  # https://user-images.githubusercontent.com/40513035/101160435-169b1080-3640-11eb-913a-3d1e80502b2b.png
  module SiteEditorsXpath
    include PageObject

    root_xpath = '//div[@class="oh_buttons"]'
    link(:run_on_your_own_server, xpath: "#{root_xpath}/a[contains(@href,'download')]")
    link(:try_in_the_cloud, xpath: "#{root_xpath}/a[contains(@href,'registration')]")
  end
end
