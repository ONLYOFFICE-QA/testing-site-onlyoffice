# https://user-images.githubusercontent.com/18173785/29405971-425532e0-8348-11e7-9ab9-f25d5ce236bd.png
# /connectors-owncloud.aspx
require_relative 'site_connector_base'

module TestingSiteOnlyffice
  class SiteConnectorOwncloud
    include PageObject
    include SiteConnectorBase

    def initialize(instance)
      super(instance, 'owncloud')
    end
  end
end
