# https://user-images.githubusercontent.com/18173785/29406099-b3d30708-8348-11e7-9d7d-f48077017a3a.png
# /connectors-alfresco.aspx
require_relative 'site_connector_base'

module TestingSiteOnlyoffice
  class SiteConnectorAlfresco
    include PageObject
    include SiteConnectorBase

    def initialize(instance)
      super(instance, 'alfresco')
    end
  end
end
