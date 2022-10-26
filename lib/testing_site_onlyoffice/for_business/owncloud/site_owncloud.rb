# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-owncloud.aspx
  # https://user-images.githubusercontent.com/67409742/164201900-43599e7a-3e07-45a9-90fb-ecd4120f8294.png
  class SiteOwnCloud < SiteForBusiness
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'ownCloud')
    end
  end
end
