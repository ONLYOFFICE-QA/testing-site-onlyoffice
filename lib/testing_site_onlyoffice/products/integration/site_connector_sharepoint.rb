# https://user-images.githubusercontent.com/18173785/29405588-f3f2c3de-8346-11e7-9048-6ff6eea5ce00.png
# /connectors-sharepoint.aspx
require_relative 'site_connector_base'

module TestingSiteOnlyffice
  class SiteConnectorSharepoint
    include PageObject
    include SiteConnectorBase

    def initialize(instance)
      super(instance, 'sharepoint')
    end
  end
end
