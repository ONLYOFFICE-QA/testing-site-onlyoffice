# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /office-for-sharepoint.aspx
  # https://user-images.githubusercontent.com/67409742/164203941-f648f27a-8019-46d3-961c-92358db39a5b.png
  class SiteSharePoint < SiteForBusiness
    include PageObject

    def initialize(instance)
      super(instance, @connector_type = 'SharePoint')
    end
  end
end
