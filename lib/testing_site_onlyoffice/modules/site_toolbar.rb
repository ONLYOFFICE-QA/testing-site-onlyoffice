# frozen_string_literal: true

require_relative 'site_languages'

module TestingSiteOnlyoffice
  # Top toolbar
  # https://user-images.githubusercontent.com/40513035/131658957-a3f913e1-3183-4275-b73a-ffe44b231054.png
  module SiteToolbar
    include PageObject
    include SiteLanguages

    link(:logo_home, xpath: '//header//div[contains(@class, "logo")]//a')

    # top toolbar - Products
    link(:site_products, xpath: '//a[@id="navitem_features"]')
    link(:site_products_docs, xpath: '//a[@id="navitem_features_editors"]')
    link(:site_products_document_editor, xpath: '//a[@id="navitem_features_document_editor"]')
    link(:site_products_spreadsheet_editor, xpath: '//a[@id="navitem_features_spreadsheet_editor"]')
    link(:site_products_presentation_editor, xpath: '//a[@id="navitem_features_presentation_editor"]')
    link(:site_products_docs_enterprise_edition, xpath: '//a[@id="navitem_features_docs_ee"]')
    link(:site_products_docs_developer_edition, xpath: '//a[@id="navitem_features_docs_de"]')
    link(:site_products_for_desktop, xpath: '//a[@id="navitem_features_clients_apps"]')
    link(:site_products_for_ios, xpath: '//a[@id="navitem_features_clients_mobile_ios"]')
    link(:site_products_for_android, xpath: '//a[@id="navitem_features_clients_mobile_android"]')
    link(:site_products_workspace, xpath: '//a[@id="navitem_features_workspace"]')
    link(:site_products_workspace_documents, xpath: '//a[@id="navitem_features_documents"]')
    link(:site_products_workspace_mail, xpath: '//a[@id="navitem_features_mail"]')
    link(:site_products_workspace_crm, xpath: '//a[@id="navitem_features_crm"]')
    link(:site_products_workspace_projects, xpath: '//a[@id="navitem_features_projects"]')
    link(:site_products_workspace_calendar, xpath: '//a[@id="navitem_features_calendar"]')
    link(:site_products_workspace_cloud_edition, xpath: '//a[@id="navitem_features_cloud_service"]')
    link(:site_products_workspace_enterprise_edition, xpath: '//a[@id="navitem_features_workspace_ee"]')
    link(:site_products_security, xpath: '//a[@id="navitem_features_security"]')

    # top toolbar - Integrations
    link(:site_integrations, xpath: '//a[@id="navitem_integrations"]')
    link(:site_integrations_nextcloud, xpath: '//a[@id="navitem_integrations_nextcloud"]')
    link(:site_integrations_owncloud, xpath: '//a[@id="navitem_integrations_owncloud"]')
    link(:site_integrations_confluence, xpath: '//a[@id="navitem_integrations_confluence"]')
    link(:site_integrations_alfresco, xpath: '//a[@id="navitem_integrations_alfresco"]')
    link(:site_integrations_sharepoint, xpath: '//a[@id="navitem_integrations_sharepoint"]')
    link(:site_integrations_liferay, xpath: '//a[@id="navitem_integrations_liferay"]')
    link(:site_integrations_humhub, xpath: '//a[@id="navitem_integrations_humhub"]')
    link(:site_integrations_plone, xpath: '//a[@id="navitem_integrations_plone"]')
    link(:site_integrations_nuxeo, xpath: '//a[@id="navitem_integrations_nuxeo"]')
    link(:site_integrations_chamilo, xpath: '//a[@id="navitem_integrations_chamilo"]')
    link(:site_integrations_others, xpath: '//a[@id="navitem_integrations_others"]')
    link(:site_integrations_for_developers, xpath: '//a[@id="navitem_integration_for_developers"]')

    # top toolbar - Pricing
    link(:site_pricing, xpath: '//a[@id="navitem_prices"]')
    link(:site_pricing_docs_enterprise, xpath: '//a[@id="navitem_prices_server_enterprice"]')
    link(:site_pricing_docs_developer, xpath: '//a[@id="navitem_prices_integration"]')
    link(:site_pricing_workspace_cloud, xpath: '//a[@id="navitem_prices_saas"]')
    link(:site_pricing_workspace_server, xpath: '//a[@id="navitem_prices_enterprise"]')
    link(:site_pricing_buy_from_reseller, xpath: '//a[@id="navitem_prices_reseller"]')

    # top toolbar - Get Onlyoffice
    link(:site_get_onlyoffice, xpath: '//a[@id="navitem_download"]')
    link(:site_get_onlyoffice_sign_in, xpath: '//a[@id="navitem_download_signin"]')
    link(:site_get_onlyoffice_sign_up, xpath: '//a[@id="navitem_download_signup"]')
    link(:site_get_onlyoffice_docs, xpath: '//a[@id="navitem_download_docs"]')
    link(:site_get_onlyoffice_install_onpremises, xpath: '//a[@id="navitem_download_onpremises"]')
    link(:site_get_onlyoffice_desktop_mobile, xpath: '//a[@id="navitem_download_desktop"]')
    link(:site_get_onlyoffice_other_products, xpath: '//a[@id="navitem_download_products"]')
    link(:site_get_onlyoffice_compare_editions, xpath: '//a[@id="navitem_download_compare"]')

    # top toolbar - Partners
    link(:site_partners, xpath: '//a[@id="navitem_partners"]')
    link(:site_partners_affiliates, xpath: '//a[@id="navitem_hosters"]')
    link(:site_partners_resellers, xpath: '//a[@id="navitem_resellers"]')
    link(:site_partners_find_partners, xpath: '//a[@id="navitem_find_partners"]')
    link(:site_partners_submit_request, xpath: '//a[@id="navitem_submit_request"]')
    link(:site_partners_latest_events, xpath: '//a[@id="navitem_latest_events"]')

    # top toolbar - About
    link(:site_about, xpath: '//a[@id="navitem_about"]')
    link(:site_about_about_onlyoffice, xpath: '//a[@id="navitem_about_about"]')
    link(:site_about_blog, xpath: '//a[@id="navitem_about_blog"]')
    link(:site_about_contribute, xpath: '//a[@id="navitem_about_contribute"]')
    link(:site_about_customers, xpath: '//a[@id="navitem_about_customers"]')
    link(:site_about_awards, xpath: '//a[@id="navitem_about_awards"]')
    link(:site_about_events, xpath: '//a[@id="navitem_about_events"]')
    link(:site_about_press_downloads, xpath: '//a[@id="navitem_about_pressdownloads"]')
    link(:site_about_white_papers, xpath: '//a[@id="navitem_about_whitepapers"]')
    link(:site_about_training_courses, xpath: '//a[@id="navitem_about_training_courses"]')
    link(:site_about_gift_shop, xpath: '//a[@id="navitem_about_giftshop"]')
    link(:site_about_contacts, xpath: '//a[@id="navitem_about_contacts"]')
    link(:site_about_latest_news, xpath: '//a[@id="navitem_latest_events"]')

    def click_home_logo
      logo_home_element.click
      SiteHomePage.new(@instance)
    end

    def site_toolbar_products
      {
        products_docs: {
          element: site_products_docs_element,
          class: SiteProductsDocs
        },
        products_document_editor: {
          element: site_products_document_editor_element,
          class: SiteProductsDocumentEditor
        },
        products_spreadsheet_editor: {
          element: site_products_spreadsheet_editor_element,
          class: SiteProductsSpreadsheetEditor
        },
        products_presentation_editor: {
          element: site_products_presentation_editor_element,
          class: SiteProductsPresentationEditor
        },
        products_docs_enterprise_edition: {
          element: site_products_docs_enterprise_edition_element
        },
        products_docs_developer_edition: {
          element: site_products_docs_developer_edition_element
        },
        products_desktop: {
          element: site_products_for_desktop_element,
          class: SiteProductsDesktop
        },
        products_ios: {
          element: site_products_for_ios_element,
          class: SiteProductsIos
        },
        products_android: {
          element: site_products_for_android_element,
          class: SiteProductsAndroid
        },
        products_workspace: {
          element: site_products_workspace_element,
          class: SiteProductsWorkspace
        },
        products_workspace_documents: {
          element: site_products_workspace_documents_element,
          class: SiteProductsDocumentManager
        },
        products_workspace_mail: {
          element: site_products_workspace_mail_element,
          class: SiteProductsMail
        },
        products_workspace_crm: {
          element: site_products_workspace_crm_element,
          class: SiteProductsCRM
        },
        products_workspace_projects: {
          element: site_products_workspace_projects_element,
          class: SiteProductsProjects
        },
        products_workspace_calendar: {
          element: site_products_workspace_calendar_element,
          class: SiteProductsCalendar
        },
        products_workspace_cloud_edition: {
          element: site_products_workspace_cloud_edition_element
        },
        products_workspace_enterprise_edition: {
          element: site_products_workspace_enterprise_edition_element
        },
        security: {
          element: site_products_security_element,
          class: SiteProductsSecurity
        }
      }
    end

    def site_toolbar_integrations
      {
        integrations_nextcloud: {
          element: site_integrations_nextcloud_element
        },
        integrations_owncloud: {
          element: site_integrations_owncloud_element
        },
        integrations_confluence: {
          element: site_integrations_confluence_element
        },
        integrations_alfresco: {
          element: site_integrations_alfresco_element
        },
        integrations_sharepoint: {
          element: site_integrations_sharepoint_element
        },
        integrations_liferay: {
          element: site_integrations_liferay_element
        },
        integrations_humhub: {
          element: site_integrations_humhub_element
        },
        integrations_plone: {
          element: site_integrations_plone_element
        },
        integrations_nuxeo: {
          element: site_integrations_nuxeo_element
        },
        integrations_chamilo: {
          element: site_integrations_chamilo_element
        },
        integrations_others: {
          element: site_integrations_others_element
        },
        integrations_for_developers: {
          element: site_integrations_for_developers_element
        }
      }
    end

    def site_toolbar_pricing
      {
        pricing_enterprise: {
          element: site_pricing_docs_enterprise_element,
          class: SitePriceDocsEnterprise
        },
        pricing_developer: {
          element: site_pricing_docs_developer_element,
          class: SitePriceDocsDeveloper
        },
        pricing_cloud: {
          element: site_pricing_workspace_cloud_element,
          class: SitePricingCloud
        },
        pricing_server: {
          element: site_pricing_workspace_server_element,
          class: SitePriceServerEnterprise
        },
        pricing_buy_from_reseller: {
          element: site_pricing_buy_from_reseller_element
        }
      }
    end

    def site_toolbar_get_onlyoffice
      {
        sign_in: {
          element: site_get_onlyoffice_sign_in_element,
          class: SiteSignIn
        },
        sign_up: {
          element: site_get_onlyoffice_sign_up_element,
          class: SiteSignUp
        },
        onlyoffice_workspace: {
          element: site_get_onlyoffice_install_onpremises_element,
          class: SiteWorkspaceEnterprise
        },
        onlyoffice_docs: {
          element: site_get_onlyoffice_docs_element,
          class: SiteDocsEnterprise
        },
        desktop_mobile_apps: {
          element: site_get_onlyoffice_desktop_mobile_element,
          class: SiteDesktopApps
        },
        other_products: {
          element: site_get_onlyoffice_other_products_element,
          class: SiteOtherProductsConnectors
        },
        compare_editions: {
          element: site_get_onlyoffice_compare_editions_element
        }
      }
    end

    def site_toolbar_partners
      {
        partners_submit_request: {
          element: site_partners_submit_request_element,
          class: SitePartnersRequest
        },
        partners_affiliates: {
          element: site_partners_affiliates_element
        },
        partners_resellers: {
          element: site_partners_resellers_element
        },
        partners_find_partners: {
          element: site_partners_find_partners_element
        },
        partners_latest_events: {
          element: site_partners_latest_events_element
        }
      }
    end

    def site_toolbar_about
      {
        about_onlyoffice: {
          element: site_about_about_onlyoffice_element,
          class: SiteAbout
        },
        about_blog: {
          element: site_about_blog_element,
          class: SiteBlog
        },
        about_contribute: {
          element: site_about_contribute_element
        },
        about_customers: {
          element: site_about_customers_element
        },
        about_awards: {
          element: site_about_awards_element
        },
        about_events: {
          element: site_about_events_element
        },
        about_press_downloads: {
          element: site_about_press_downloads_element
        },
        white_papers: {
          element: site_about_white_papers_element,
          class: SiteWhitePapers
        },
        training_courses: {
          element: site_about_training_courses_element,
          class: SiteAboutTrainingCourses
        },
        about_gift_shop: {
          element: site_about_gift_shop_element
        },
        about_contacts: {
          element: site_about_contacts_element
        },
        about_latest_news: {
          element: site_about_latest_news_element
        }
      }
    end

    def all_toolbar_links_and_classes_hash
      site_toolbar_products.merge(site_toolbar_integrations, site_toolbar_get_onlyoffice, site_toolbar_pricing,
                                  site_toolbar_partners, site_toolbar_about)
    end

    def click_link_on_toolbar(section)
      @instance.webdriver.move_to_element_by_locator(site_products_element.selector[:xpath]) if site_toolbar_products.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_integrations_element.selector[:xpath]) if site_toolbar_integrations.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_get_onlyoffice_element.selector[:xpath]) if site_toolbar_get_onlyoffice.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_pricing_element.selector[:xpath]) if site_toolbar_pricing.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_partners_element.selector[:xpath]) if site_toolbar_partners.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_about_element.selector[:xpath]) if site_toolbar_about.key?(section)
      link = all_toolbar_links_and_classes_hash[section][:element]
      @instance.webdriver.wait_until { link.present? }
      link.click
      all_toolbar_links_and_classes_hash[section][:class].new(@instance)
    end
  end
end
