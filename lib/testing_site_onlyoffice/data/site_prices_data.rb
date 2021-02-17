module TestingSiteOnlyoffice
  class SitePricesData
    def self.developer_edition_single_server_250
      return 5_875 if StaticDataTeamLab.current_language == 'ru-RU'

      7_000
    end

    def self.developer_edition_single_server_500
      return 11_750 if StaticDataTeamLab.current_language == 'ru-RU'

      14_000
    end

    def self.developer_edition_single_server_1000
      return 23_500 if StaticDataTeamLab.current_language == 'ru-RU'

      28_000
    end

    def self.developer_edition_developer_server
      return 72_000 if StaticDataTeamLab.current_language == 'ru-RU'

      1500
    end
  end
end
