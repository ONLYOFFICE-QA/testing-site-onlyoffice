# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site pricing data
  class SitePricesData
    def self.cloud_services_price_periods
      %i[month year-1 year-3]
    end

    def self.developer_edition_single_server_250
      return 5_875 if config.language == 'ru-RU'

      7_000
    end

    def self.developer_edition_single_server_500
      return 11_750 if config.language == 'ru-RU'

      14_000
    end

    def self.developer_edition_single_server_1000
      return 23_500 if config.language == 'ru-RU'

      28_000
    end

    def self.developer_edition_developer_server
      return 72_000 if config.language == 'ru-RU'

      1500
    end
  end
end
