# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site pricing data
  class SitePricesData
    def self.cloud_services_price_periods
      %i[month year-1]
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

    def self.plus_support_50
      return 1250 if SiteData.european_languages.include? config.language

      1480
    end

    def self.plus_support_100
      return 2000 if SiteData.european_languages.include? config.language

      2380
    end

    def self.premium_support_50
      return 3250 if SiteData.european_languages.include? config.language

      3850
    end

    def self.premium_support_100
      return 5200 if SiteData.european_languages.include? config.language

      6160
    end

    def self.support_users
      {
        min: 50,
        min_increased: 100
      }
    end
  end
end
