# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-redmine.aspx
  # https://user-images.githubusercontent.com/67409742/164888754-777135b5-72f6-4e02-a041-80f51645c070.png
  class SiteRedmine < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Redmine')
    end
  end
end
