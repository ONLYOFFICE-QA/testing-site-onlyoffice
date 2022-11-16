# frozen_string_literal: true

require_relative '../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  # Helper for checking home page links
  module SiteHomePageHelper
    include PageObject
    include SiteDownloadHelper

    link(:blog_news, xpath: "//div[@id = 'dp-blog-slider']/a")
    link(:webinar_news, xpath: "//div[@id = 'dp-webinars-slider']//a")

    def desktop_and_mobile_apps_element_works?(app)
      app_xpath = "//a[contains(@class, 'platform-icon #{app}')]"
      xpath_success_response?(app_xpath)
    end

    def built_for_everyone_element_works?(solution)
      solution_xpath = "//div[contains(@class,'footer_menu_item')]/div/a[text() = '#{solution}']"
      xpath_success_response?(solution_xpath)
    end

    def rated_by_critics_element_works?(app)
      app_xpath = "//div[@class='dp-r-medals']//div[contains(@class, '#{app}')]/../.."
      app_xpath = "//div[@class='dp-r-medals']//a[contains(@href, 'sourceforge')]" if app == 'sourceforge'

      xpath_success_response?(app_xpath)
    end

    def rated_by_users_element_works?(app)
      app_xpath = "//div[@class='dp-r-ls']//div[contains(@class, '#{app}')]/a"
      xpath_success_response?(app_xpath)
    end

    def xpath_success_response?(xpath)
      link_element = @instance.webdriver.driver.find_element(:xpath, xpath)
      link_success_response?(link_element.attribute('href'))
    end
  end
end
