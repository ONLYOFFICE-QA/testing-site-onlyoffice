# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Data for links on main page
  class MainPageLinksData
    def self.rated_by_critics
      %w[getapp capterra highperformer cloudinsider softwareadvicemr sourceforge]
    end

    def self.rated_by_users
      %w[sourceforge getapp softwareadvice softpedia capterra pcmag]
    end

    GET_ONLYOFFICE_BUTTONS_XPATH = "//div[contains(@class,'dp-d-btns')]"
    CHOOSE_SOLUTION_XPATH = "//div[contains(@class, 'choose_solution')]"

    def self.get_onlyoffice_main_page
      {
        'OnlyOffice Docs Get It Now': "(#{GET_ONLYOFFICE_BUTTONS_XPATH})//a[contains(@href, 'download-docs')]",
        'OnlyOffice See it in action': "(#{GET_ONLYOFFICE_BUTTONS_XPATH})//a[contains(@href, 'see-it-in-action')]",
        'OnlyOffice Docs Learn more': "//div[contains(@class,'dp-m-inside')]//a[contains(@href, 'office-suite')]",
        'OnlyOffice DocSpace Learn more': "(#{CHOOSE_SOLUTION_XPATH})//a[contains(@href, '/docspace.aspx')]",
        'OnlyOffice Docs Developer Edition': "(#{CHOOSE_SOLUTION_XPATH})//a[contains(@href, '/developer-edition.aspx')]",
        'OnlyOffice Desktop apps': "(#{CHOOSE_SOLUTION_XPATH})//a[contains(@href, '/download-desktop.aspx')]",
        'OnlyOffice Mobile apps': "(#{CHOOSE_SOLUTION_XPATH})//a[contains(@href, '/download-desktop.aspx#mobile')]"
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
