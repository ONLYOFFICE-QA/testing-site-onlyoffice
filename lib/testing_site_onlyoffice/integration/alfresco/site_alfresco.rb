# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-alfresco.aspx
  # https://user-images.githubusercontent.com/67409742/164202575-9ec9207e-970d-4eeb-8ca4-e1c275701436.png
  class SiteAlfresco < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Alfresco')
    end
  end
end
