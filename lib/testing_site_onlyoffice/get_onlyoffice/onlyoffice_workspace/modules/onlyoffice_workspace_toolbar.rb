# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Onlyoffice Docs top toolbar
  # https://user-images.githubusercontent.com/40513035/131134320-3ce4947a-ae0a-4659-8375-f6a0907ff810.png
  module SiteToolbarOnlyofficeWorkspace
    include PageObject

    div(:site_workspace_enterprise, xpath: '//div[@id = "workspace-enterprise"]')
    div(:site_workspace_community, xpath: '//div[@id = "workspace-community"]')

    def site_workspace_enterprise_download
      site_workspace_enterprise_element.click
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end

    def site_workspace_community_download
      site_workspace_community_element.click
      SiteWorkspaceCommunity.new(@instance)
    end
  end
end
