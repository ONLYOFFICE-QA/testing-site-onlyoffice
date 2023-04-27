# frozen_string_literal: true

require_relative 'modules/site_groups_xpath'
require_relative 'modules/site_for_business_workspace_methods'

module TestingSiteOnlyoffice
  # /projects.aspx
  # https://user-images.githubusercontent.com/40513035/101334070-6f5cea00-3888-11eb-9129-6366bf1199bd.png
  class SiteWorkspaceProjects
    include PageObject
    include SiteGroupsXpath
    include SiteForBusinessWorkspaceMethods
    include SiteToolbar

    div(:projects_identification, xpath: "//div[contains(@class,'collaborationprojects')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(run_on_your_own_server_element) && @instance.webdriver.element_present?(projects_identification_element)
      end
    end
  end
end
