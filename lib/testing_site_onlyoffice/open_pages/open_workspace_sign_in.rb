# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for directly opening the workspace sign_in page,
  # as it was removed from the site menu but still needs testing
  module OpenWorkspaceSignIn
    def open_workspace_sign_in_page
      url = "#{config.server}/signin.aspx"
      @instance.webdriver.open(url)
      SiteGetOnlyofficeSignIn.new(@instance)
    end
  end
end
