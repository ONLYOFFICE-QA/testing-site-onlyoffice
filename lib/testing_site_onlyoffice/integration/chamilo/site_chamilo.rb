# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-chamilo.aspx
  # https://user-images.githubusercontent.com/67409742/164888858-f6134a8e-71c3-4f02-bc94-bf70fd1f5c16.png
  class SiteChamilo < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Online office for Chamilo')
    end
  end
end
