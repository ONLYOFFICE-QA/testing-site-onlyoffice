# frozen_string_literal: true

require_relative '../../modules/site_toolbar'

module TestingSiteOnlyoffice
  # compare-editions.aspx
  # https://user-images.githubusercontent.com/67409742/162945894-c49dcb62-f413-4540-b96b-cce64bdb60e1.png
  class SiteCompareEdition
    include PageObject
    include SiteToolbar

    element(:header_name, xpath: '//div[@class="description"]/h2')
    link(:get_it_now, xpath: '//a[contains(@href,"/download-docs.aspx#docs-community")]')
    link(:help_center_community_edition, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/installation/docs-community-index.aspx")]')
    link(:help_center_enterprise_edition, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/installation/docs-enterprise-index.aspx")]')
    link(:help_center_developer_edition, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/installation/docs-developer-index.aspx")]')
    link(:git_hub, xpath: '//a[contains(@href,"https://github.com/ONLYOFFICE/DocumentServer/issues")]')
    link(:enterprise_prices, xpath: '//a[contains(@href,"docs-enterprise-prices.aspx?from=compare-editions")]')
    link(:developer_prices, xpath: '//a[contains(@href,"developer-edition-prices.aspx?")]')
    link(:enterprise_free_trial, xpath: '//a[contains(@href,"/download-docs.aspx?from=compare-editions#docs-enterprise")]')
    link(:developer_free_trial, xpath: '//a[contains(@href,"/download-docs.aspx?from=compare-editions#docs-developer")]')
    link(:proprietary_enterprise, xpath: '//a[contains(@href,"https://help.onlyoffice.com/features/files/doceditor.aspx?fileid=4")]')
    link(:proprietary_developer, xpath: '//a[contains(@href,"https://help.onlyoffice.com/features/files/doceditor.aspx?fileid=55")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(header_name_element) }
      name_header == 'Compare ONLYOFFICE Docs editions'
    end

    def name_header
      @instance.webdriver.get_text(header_name_element)
    end

    def parse_url
      current_url = URI(@instance.webdriver.current_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def check_button_get_it_now?
      get_it_now_element.click
      SiteDocsCommunity.new(@instance)
    end

    def check_button_enterprise_prices?
      enterprise_prices_element.click
      SitePriceDocsEnterprise.new(@instance)
    end

    def check_button_developer_prices?
      developer_prices_element.click
      SitePriceDocsDeveloper.new(@instance)
    end

    def check_button_enterprise_free_trial?
      enterprise_free_trial_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def check_button_developer_free_trial?
      developer_free_trial_element.click
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_opened_enterprise_license_agreement
      proprietary_enterprise_element.click
      document_opening_processing.include?('ONLYOFFICE Docs Enterprise Edition')
    end

    def check_opened_developer_license_agreement
      proprietary_developer_element.click
      document_opening_processing.include?('ONLYOFFICE Docs Developer Edition')
    end

    def document_opening_processing
      @instance.webdriver.switch_to_popup
      @instance.init_online_documents
      @instance.doc_instance.management.wait_for_operation_with_round_status_canvas
      @instance.doc_instance.doc_editor.top_toolbar.title_row.document_name
    end

    def check_link?(section)
      attribute = @instance.webdriver.get_attribute(move_to_link[section][:element], 'href')
      link = move_to_link[section][:element]
      link.click
      @instance.webdriver.switch_to_popup
      attribute.include?(parse_url)
    end

    def move_to_link
      {
        help_center_community_edition: {
          element: help_center_community_edition_element
        },
        help_center_enterprise_edition: {
          element: help_center_enterprise_edition_element
        },
        help_center_developer_edition: {
          element: help_center_developer_edition_element
        },
        git_hub: {
          element: git_hub_element
        }
      }
    end
  end
end
