# frozen_string_literal: true

require_relative '../modules/site_groups_xpath'

module TestingSiteOnlyoffice
  # /projects.aspx
  # https://user-images.githubusercontent.com/40513035/101334070-6f5cea00-3888-11eb-9129-6366bf1199bd.png
  class SiteProductsProjects
    include PageObject
    include SiteGroupsXpath
    include SiteToolbar

    div(:projects_identification, xpath: "//div[contains(@class,'collaborationprojects')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        run_on_your_own_server_element.present? && projects_identification_element.present?
      end
    end
  end
end
