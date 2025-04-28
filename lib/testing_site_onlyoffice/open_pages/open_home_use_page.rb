# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for directly opening enterprise pages,
  # as it was removed from the site menu but still needs testing
  module OpenHomeUsePage
    def open_home_use_page
      url = "#{config.server}/home-use.aspx"
      @instance.webdriver.open(url)
      SiteHomeUse.new(@instance)
    end
  end
end
