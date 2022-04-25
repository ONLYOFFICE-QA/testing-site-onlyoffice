# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-moodle.aspx
  # https://user-images.githubusercontent.com/67409742/164888839-5056e504-76f0-4d6d-be29-8c7a259f38f5.png
  class SiteMoodle < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Moodle')
    end
  end
end
