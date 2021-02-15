# https://user-images.githubusercontent.com/18173785/29405920-14b71e7a-8348-11e7-841c-df1cf272df58.png
# /connectors-nextcloud.aspx
require_relative 'site_connector_base'

module TestingSiteOnlyffice
  class SiteConnectorNextcloud
    include PageObject
    include SiteConnectorBase

    def initialize(instance)
      super(instance, 'nextcloud')
    end
  end
end
