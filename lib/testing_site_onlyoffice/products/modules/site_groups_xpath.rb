# Try in the cloud and Run on your own server xpath for groups
# https://user-images.githubusercontent.com/40513035/101329235-2dc94080-3882-11eb-8591-ff3c2a1cac1d.png

module TestingSiteOnlyffice
  module SiteGroupsXpath
    include PageObject

    root_xpath = '//div[@class="col_buttons"]'
    link(:run_on_your_own_server, xpath: "#{root_xpath}/a[contains(@href,'download')]")
    link(:try_in_the_cloud, xpath: "#{root_xpath}/a[contains(@href,'registration')]")
  end
end
