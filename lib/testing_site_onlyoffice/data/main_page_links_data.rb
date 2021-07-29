# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Data for links on main page
  class MainPageLinksData
    def self.free_desktop_and_mobile_apps
      %w[for_windows for_linux for_macos googleplay appstore]
    end

    def self.built_for_everyone
      %w[smbs enterprises education developers government nonprofit research healthcare hosting home]
    end

    def self.rated_by_critics
      %w[getapp capterra highperformer appvizer softwareadvicemr appstore]
    end

    def self.rated_by_users
      %w[sourceforge getapp softwareadvice softpedia capterra pcmag]
    end

    GET_ONLYOFFICE_BLOCK_XPATH = "//div[@class = 'dp-designed']"

    def self.get_onlyoffice_main_page
      {
        'Workspace Try in the Cloud': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[1]//a[@class='button orange-button']",
        'Workspace Deploy on your own server': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[1]//a[@class='button gray-button']",
        'Docs Get It Now': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[2]//a[@class='button gray-button']",
        'Docs Learn more': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[2]//div[@class='dp-link']/a",
        'Groups Get It Now': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[3]//a[@class='button gray-button']",
        'Groups Learn more': "(#{GET_ONLYOFFICE_BLOCK_XPATH})[3]//div[@class='dp-link']/a"
      }
    end

    def self.customers_main_page
      {
        'More customer': "(//div[@class='customers_newdesign']/div[@class='dp-link']/a)[1]",
        'First success stories': "(//div[@class='dp-cn-case']//a)[1]",
        'Second success stories': "(//div[@class='dp-cn-case']//a)[2]",
        'More success stories': "(//div[@class='customers_newdesign']/div[@class='dp-link']/a)[2]"
      }
    end
  end
end
