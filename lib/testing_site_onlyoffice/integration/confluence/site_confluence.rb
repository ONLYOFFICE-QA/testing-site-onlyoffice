# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-confluence.aspx
  # https://user-images.githubusercontent.com/67409742/164202963-73354f24-e687-49bd-9994-5f40e2f750d2.png
  class SiteConfluence < SiteIntegration
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'Confluence')
    end
  end
end
