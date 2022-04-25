# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-nuxeo.aspx
  # https://user-images.githubusercontent.com/67409742/164888674-6c3b12d7-6841-40c2-a431-9702af8f95f3.png
  class SiteNuxeo < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Nuxeo')
    end
  end
end
