# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-jira.aspx
  # https://user-images.githubusercontent.com/67409742/164888804-ad0d1097-d3c1-41dd-894b-bc2e30fe927a.png
  class SiteJira < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Jira')
    end
  end
end
