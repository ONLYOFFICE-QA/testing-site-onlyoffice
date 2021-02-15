# frozen_string_literal: true

# https://cloud.githubusercontent.com/assets/18173785/22210192/090c46ae-e19a-11e6-9a40-bbbcee366377.png
# /awards.aspx
module TestingSiteOnlyffice
  class SiteAwards
    include PageObject

    # identification
    body(:identifier, xpath: '//body[@id="awardspage"]')

    # awards
    link(:award_getapp, xpath: '//a[contains(@href, "getapp")]')
    link(:award_softpedia, xpath: '//a[contains(@href, "softpedia")]')
    link(:award_pcmag, xpath: '//a[contains(@href, "pcmag")]')
    link(:award_findmysoft, xpath: '//a[contains(@href, "findmysoft")]')
    link(:award_raritysoft, xpath: '//a[contains(@href, "raritysoft")]')
    link(:award_financesonline, xpath: '//a[contains(@href, "financesonline")]')
    link(:award_badcredit_or_livebusiness, xpath: '//a[contains(@href, "badcredit") or contains(@href, "livebusiness")]')

    # de awards
    link(:award_freeware, xpath: '//a[contains(@href, "freeware")]')
    link(:award_pcwelt, xpath: '//a[contains(@href, "pcwelt")]')
    link(:award_chip, xpath: '//a[contains(@href, "chip")]')
    link(:award_linuxmagazin, xpath: '//a[contains(@href, "linux-magazin")]')
    link(:award_heise, xpath: '//a[contains(@href, "heise")]')
    link(:award_netzwelt, xpath: '//a[contains(@href, "netzwelt")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { identifier_element.present? }
    end

    def getapp_visible?
      award_getapp_element.present?
    end

    def softpedia_visible?
      award_softpedia_element.present?
    end

    def pcmag_visible?
      award_pcmag_element.present?
    end

    def findmysoft_visible?
      award_findmysoft_element.present?
    end

    def raritysoft_visible?
      award_raritysoft_element.present?
    end

    def financesonline_visible?
      award_financesonline_element.present?
    end

    # de: freeware.de, pcwelt, chip, linux-magazin.de, others
    def freeware_visible?
      award_freeware_element.present?
    end

    def pcwelt_visible?
      award_pcwelt_element.present?
    end

    def chip_visible?
      award_chip_element.present?
    end

    def linuxmagazin_visible?
      award_linuxmagazin_element.present?
    end

    def heise_visible?
      award_heise_element.present?
    end

    def netzwelt_visible?
      award_netzwelt_element.present?
    end

    %w[freeware pcwelt chip linuxmagazin heise netzwelt].each do |award_link|
      define_method "#{award_link}_link_alive?" do
        link_success_response?(href_text(send("award_#{award_link}_element")))
      end
    end

    # ru: livebusines, others: badcredit
    def badcredit_livebusiness_visible?
      # 8th award site only for RU/EN languages
      return true unless %w[ru-RU en-US].include? StaticDataTeamLab.current_language

      award_badcredit_or_livebusiness_element.present?
    end

    def getapp_link_alive?
      check_link_by_curl(award_getapp_element.href)
    end

    def softpedia_link_alive?
      check_link_by_curl(href_text(award_softpedia_element))
    end

    def pcmag_link_alive?
      link_success_response?(href_text(award_pcmag_element))
    end

    def findmysoft_link_alive?
      link_success_response?(href_text(award_findmysoft_element))
    end

    def raritysoft_link_alive?
      link_success_response?(href_text(award_raritysoft_element))
    end

    def financesonline_link_alive?
      link_success_response?(href_text(award_financesonline_element))
    end

    def badcredit_livebusiness_link_alive?
      # 8th award site only for RU/EN languages
      return true unless %w[ru-RU en-US].include? StaticDataTeamLab.current_language

      link_success_response?(href_text(award_badcredit_or_livebusiness_element))
    end

    private

    # @param link [String] check link
    # @return [True, False] is link correct
    def check_link_by_curl(link)
      `curl --head -L #{link}`.include?('200 OK')
    end
  end
end
