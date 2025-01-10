# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for directly opening download pages,
  # as it was removed from the site menu but still needs testing
  module OpenDownloadPages
    def open_download_docbuilder_page
      url = "#{config.server}/download-builder.aspx"
      @instance.webdriver.open(url)
      SiteGetOnlyofficeDownloadDocBuilder.new(@instance)
    end

    def open_community_download_page
      url = "#{config.server}/download-community.aspx"
      @instance.webdriver.open(url)
      SiteGetOnlyofficeDocsCommunity.new(@instance)
    end

    def open_download_workspace_enterprise_page
      url = "#{config.server}/download-workspace.aspx"
      @instance.webdriver.open(url)
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end
  end
end
