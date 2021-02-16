# https://user-images.githubusercontent.com/18173785/29406169-ed102096-8348-11e7-9940-667067824abc.png
# /connectors-confluence.aspx
require_relative 'site_connector_base'

module TestingSiteOnlyffice
  class SiteConnectorConfluence
    include PageObject
    include SiteConnectorBase

    def initialize(instance)
      super(instance, 'confluence')
    end
  end
end
