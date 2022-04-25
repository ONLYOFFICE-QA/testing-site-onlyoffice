# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-plone.aspx
  # https://user-images.githubusercontent.com/67409742/164888713-e3e5365f-2a4b-40e6-957a-b623f94b8bfa.png
  class SitePlone < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Plone')
    end
  end
end
