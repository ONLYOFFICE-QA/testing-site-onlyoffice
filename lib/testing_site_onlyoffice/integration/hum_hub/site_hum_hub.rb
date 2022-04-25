# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-humhub.aspx
  # https://user-images.githubusercontent.com/67409742/164203342-e59863b9-26ba-4325-a992-5f6351a90748.png
  class SiteHumHub < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'HumHub')
    end
  end
end
