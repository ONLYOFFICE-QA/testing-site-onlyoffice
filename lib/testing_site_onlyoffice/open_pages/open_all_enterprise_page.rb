# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for directly opening enterprise pages,
  # as it was removed from the site menu but still needs testing
  module OpenAllEnterprisePage
    def open_for_enterprise_page
      url = "#{config.server}/for-enterprises.aspx"
      @instance.webdriver.open(url)
      SiteEnterpriseOverview.new(@instance)
    end
  end
end
