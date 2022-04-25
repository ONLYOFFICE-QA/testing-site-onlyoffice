# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-liferay.aspx
  # https://user-images.githubusercontent.com/67409742/164203654-ef456e86-2bc7-40e2-a5b0-dffcaafd3b25.png
  class SiteLiferay < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Liferay')
    end
  end
end
