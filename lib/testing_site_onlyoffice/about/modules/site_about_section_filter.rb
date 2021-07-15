# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Left side section filter for /whitepapers.aspx and /training-courses.aspx pages
  # https://user-images.githubusercontent.com/40513035/125739827-bb06f902-ad56-42f8-8b3e-96c6962cf0eb.png
  module SiteAboutSectionFilter
    include PageObject

    element(:current_left_side_filter, xpath: "//div[@class='choose-item-type popup-starting-point']/h2")

    def click_left_filter_element(type)
      current_left_side_filter_element.click
      filter_xpath = "(//div[@class='filter-selector']/div[text()='#{type}'])[1]"
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(filter_xpath) }
      @instance.webdriver.driver.find_element(:xpath, filter_xpath).click
      @instance.webdriver.wait_until { current_left_side_filter_element.text == type }
    end

    def change_left_filter(type)
      return if current_left_side_filter_element.text == type.to_s

      click_left_filter_element(type.to_s)
    end
  end
end
