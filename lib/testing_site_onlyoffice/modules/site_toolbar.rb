# frozen_string_literal: true

require_relative 'site_languages'

module TestingSiteOnlyoffice
  # Top toolbar
  # https://user-images.githubusercontent.com/40513035/131658957-a3f913e1-3183-4275-b73a-ffe44b231054.png
  module SiteToolbar
    include PageObject
    include SiteLanguages

    # This xpath for logo is only applicable for Blog
    link(:logo_home, xpath: '//header//div[contains(@class, "navbar")]/a')

    # top toolbar - Features
    link(:site_features, xpath: '//a[@id="navitem_features"]')
    link(:site_features_connectors, xpath: '//a[@id="navitem_features_connectors"]')
    link(:site_features_docspace, xpath: '//a[@id="navitem_features_docspace"]')
    link(:site_features_workspace, xpath: '//a[@id="navitem_features_workspace"]')
    link(:site_features_marketplace, xpath: '//a[@id="navitem_features_marketplace"]')
    link(:site_features_docs_overview, xpath: '//a[@id="navitem_features_docs_overview"]')
    link(:site_features_document_editor, xpath: '//a[@id="navitem_features_document_editor"]')
    link(:site_features_spreadsheet_editor, xpath: '//a[@id="navitem_features_spreadsheet_editor"]')
    link(:site_features_presentation_editor, xpath: '//a[@id="navitem_features_presentation_editor"]')
    link(:site_features_form_creator, xpath: '//a[@id="navitem_features_form_creator"]')
    link(:site_features_pdf_reader_converter, xpath: '//a[@id="navitem_features_pdf_reader"]')
    link(:site_features_for_desktop, xpath: '//a[@id="navitem_features_clients_apps"]')
    link(:site_features_for_ios, xpath: '//a[@id="navitem_features_clients_mobile_ios"]')
    link(:site_features_for_android, xpath: '//a[@id="navitem_features_clients_mobile_android"]')
    link(:site_features_security, xpath: '//a[@id="navitem_features_security"]')
    link(:site_features_see_it_in_action, xpath: '//a[@id="navitem_features_see_it"]')
    link(:site_features_oforms, xpath: '//a[@id="navitem_features_fill_forms"]')
    link(:site_features_text_converter, xpath: '//a[@id="navitem_features_convert_text"]')
    link(:site_features_spreadsheet_converter, xpath: '//a[@id="navitem_features_convert_speadsheets"]')
    link(:site_features_presentation_converter, xpath: '//a[@id="navitem_features_convert_presentations"]')
    link(:site_features_pdf_converter, xpath: '//a[@id="navitem_features_convert_pdf"]')

    # top toolbar - For Business
    link(:site_for_enterprises, xpath: '//a[@id = "navitem_forbusiness"]')
    link(:site_for_enterprises_overview, xpath: '//a[@id = "navitem_fb_business"]')
    link(:site_for_business_docs_enterprise, xpath: '//a[@id="navitem_fb_docs_ee"]')
    link(:site_for_business_workspace, xpath: '//a[@id="navitem_fb_workspace"]')
    link(:site_for_business_nextcloud, xpath: '//a[@id="navitem_integrations_nextcloud"]')
    link(:site_for_business_owncloud, xpath: '//a[@id="navitem_integrations_owncloud"]')
    link(:site_for_business_confluence, xpath: '//a[@id="navitem_integrations_confluence"]')
    link(:site_for_business_alfresco, xpath: '//a[@id="navitem_integrations_alfresco"]')
    link(:site_for_business_moodle, xpath: '//a[@id="navitem_integrations_moodle"]')
    link(:site_for_business_all, xpath: '//a[@id="navitem_integrations_others"]')
    link(:site_for_business_for_education, xpath: '//a[@id="navitem_features_education"]')
    link(:site_docspace_enterprise, xpath: '//a[@id="navitem_fb_docspace_ee"]')

    # top toolbar - For Developers
    link(:site_for_developers, xpath: '//a[@id="navitem_fordevelopers"]')
    link(:site_for_developers_all_solutions, xpath: '//a[@id="navitem_fd_dev_solutions"]')
    link(:site_for_developers_doc_dev_edition, xpath: '//a[@id="navitem_fd_docs_dev"]')
    link(:site_for_developers_doc_builder, xpath: '//a[@id="navitem_fd_doc_builder"]')
    link(:site_for_developers_api_doc, xpath: '//a[@id="navitem_fd_api_doc"]')

    # top toolbar - Get Onlyoffice
    link(:site_get_onlyoffice, xpath: '//a[@id="navitem_download"]')
    link(:site_get_onlyoffice_docs_registration, xpath: '//a[@id="navitem_docs_signup"]')
    link(:site_get_onlyoffice_install_onpremises, xpath: '//a[@id="navitem_download_onpremises"]')
    link(:site_get_onlyoffice_sign_in, xpath: '//a[@id="navitem_download_signin"]')
    link(:site_get_onlyoffice_docspace_sign_in, xpath: '//a[@id = "navitem_docspace_signin"]')
    link(:site_get_onlyoffice_docspace_sign_up, xpath: '//a[@id = "navitem_docspace_signup"]')
    link(:site_get_onlyoffice_connectors, xpath: '//a[@id="navitem_download_connectors"]')
    link(:site_get_onlyoffice_desktop_mobile, xpath: '//a[@id="navitem_download_desktop_mob"]')
    link(:site_get_onlyoffice_docs_developer, xpath: '//a[@id="navitem_docs_de_onpremises"]')
    link(:site_get_onlyoffice_docs_enterprise, xpath: '//a[@id="navitem_docs_onpremises"]')
    link(:site_get_onlyoffice_docs_community, xpath: '//a[@id="navitem_download_docs_ce"]')
    link(:site_get_onlyoffice_document_builder, xpath: '//a[@id="navitem_download_docs_builder"]')
    link(:site_get_onlyoffice_web_hosting, xpath: '//a[@id="navitem_download_hosting"]')
    link(:site_get_onlyoffice_github_code, xpath: '//a[@id="navitem_download_code_git"]')

    # top toolbar - Pricing
    link(:site_pricing, xpath: '//a[@id="navitem_prices"]')
    link(:site_pricing_docs_enterprise, xpath: '//a[@id="navitem_prices_docs_enterprice"]')
    link(:site_pricing_workspace, xpath: '//a[@id="navitem_prices_workspace"]')
    link(:site_pricing_docspace, xpath: '//a[@id="navitem_prices_docspace"]')
    link(:site_pricing_docs_developer, xpath: '//a[@id="navitem_prices_docs_dev"]')
    link(:site_pricing_buy_from_reseller, xpath: '//a[@id="navitem_prices_reseller"]')

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
    link(:site_about_forum, xpath: '//a[@id="navitem_about_forum"]')
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
    link(:site_about_help_center, xpath: '//a[@id="navitem_about_help"]')
    link(:site_about_webinars, xpath: '//a[@id="navitem_about_webinars"]')
    link(:site_about_jobs, xpath: '//a[@id="navitem_about_vacancies"]')
    link(:site_about_compare, xpath: '//a[@id="navitem_about_compare"]')

    def click_home_logo
      logo_home_element.click
      SiteHomePage.new(@instance)
    end

    def site_toolbar_features
      {
        features_connectors: {
          element: site_features_connectors_element,
          class: SiteConnectorsOnlyoffice
        },
        features_workspace: {
          element: site_features_workspace_element,
          class: SiteFeaturesWorkspace
        },
        features_docspace: {
          element: site_features_docspace_element,
          class: SiteDocSpaceMainPage
        },
        features_marketplace: {
          element: site_features_marketplace_element,
          class: SiteFeaturesMarketplace
        },
        features_document_overview: {
          element: site_features_docs_overview_element,
          class: SiteFeaturesDocsOverview
        },
        features_document_editor: {
          element: site_features_document_editor_element,
          class: SiteFeaturesDocumentEditor
        },
        features_spreadsheet_editor: {
          element: site_features_spreadsheet_editor_element,
          class: SiteFeaturesSpreadsheetEditor
        },
        features_presentation_editor: {
          element: site_features_presentation_editor_element,
          class: SiteFeaturesPresentationEditor
        },
        features_form_creator: {
          element: site_features_form_creator_element,
          class: SiteFeaturesFormCreator
        },
        features_pdf_reader_converter: {
          element: site_features_pdf_reader_converter_element,
          class: SiteFeaturesPDFReaderConverter
        },
        features_desktop: {
          element: site_features_for_desktop_element,
          class: SiteFeaturesDesktop
        },
        features_ios: {
          element: site_features_for_ios_element,
          class: SiteFeaturesIos
        },
        features_android: {
          element: site_features_for_android_element,
          class: SiteFeaturesAndroid
        },
        security: {
          element: site_features_security_element,
          class: SiteFeaturesSecurity
        },
        features_see_it_in_action: {
          element: site_features_see_it_in_action_element,
          class: SiteFeaturesSeeItInAction
        },
        features_oforms: {
          element: site_features_oforms_element,
          class: SiteFeaturesOforms
        },
        site_features_text_converter: {
          element: site_features_text_converter_element,
          class: ConvertPage
        },
        site_features_spreadsheet_converter: {
          element: site_features_spreadsheet_converter_element,
          class: ConvertPage
        },
        site_features_presentation_converter: {
          element: site_features_presentation_converter_element,
          class: ConvertPage
        },
        site_features_pdf_converter: {
          element: site_features_pdf_converter_element,
          class: ConvertPage
        }

      }
    end

    def site_toolbar_for_business
      {
        for_enterprises_overview: {
          element: site_for_enterprises_overview_element,
          class: SiteEnterpriseOverview
        },
        for_enterprises_docs: {
          element: site_for_business_docs_enterprise_element,
          class: SiteForBusinessDocsEnterpriseEdition
        },
        docspace_enterprise: {
          element: site_docspace_enterprise_element,
          class: SiteDocSpaceEnterprise
        }
      }
    end

    def site_toolbar_for_developers
      {
        for_developers_doc_dev_edition: {
          element: site_for_developers_doc_dev_edition_element,
          class: SiteForDevelopersDocDevEdition
        },
        for_developers_all_solutions: {
          element: site_for_developers_all_solutions_element,
          class: SiteForDevelopers
        },
        for_developers_document_builder: {
          element: site_for_developers_doc_builder_element,
          class: SiteForDevelopersDocBuilder
        },
        for_developers_api_doc: {
          element: site_for_developers_api_doc_element,
          class: SiteForDevelopersApiDoc
        }
      }
    end

    def site_toolbar_get_onlyoffice
      {
        get_onlyoffice_docs_registration: {
          element: site_get_onlyoffice_docs_registration_element,
          class: DocsRegistrationPage
        },
        get_onlyoffice_workspace_on_premises: {
          element: site_get_onlyoffice_install_onpremises_element,
          class: SiteGetOnlyofficeWorkspaceEnterprise
        },
        get_onlyoffice_sign_in: {
          element: site_get_onlyoffice_sign_in_element,
          class: SiteGetOnlyofficeSignIn
        },
        get_onlyoffice_docspace_sign_in: {
          element: site_get_onlyoffice_docspace_sign_in_element,
          class: SiteDocSpaceSignIn
        },
        get_onlyoffice_connectors: {
          element: site_get_onlyoffice_connectors_element,
          class: SiteConnectorsOnlyoffice
        },
        get_onlyoffice_desktop_mobile: {
          element: site_get_onlyoffice_desktop_mobile_element,
          class: SiteGetOnlyofficeDesktopApps
        },
        get_onlyoffice_docs_developer: {
          element: site_get_onlyoffice_docs_developer_element,
          class: SiteGetOnlyofficeDocsDeveloper
        },
        get_onlyoffice_docs_enterprise: {
          element: site_get_onlyoffice_docs_enterprise_element,
          class: SiteGetOnlyofficeDocsEnterprise
        },
        get_onlyoffice_docs_community: {
          element: site_get_onlyoffice_docs_community_element,
          class: SiteGetOnlyofficeDocsCommunity
        },
        get_onlyoffice_document_builder: {
          element: site_get_onlyoffice_document_builder_element,
          class: SiteGetOnlyofficeDownloadDocBuilder
        },
        get_onlyoffice_web_hosting: {
          element: site_get_onlyoffice_web_hosting_element,
          class: SiteGetOnlyofficeWebHosting
        },
        get_onlyoffice_github_code: {
          element: site_get_onlyoffice_github_code_element
        }
      }
    end

    def site_toolbar_pricing
      {
        pricing_enterprise: {
          element: site_pricing_docs_enterprise_element,
          class: SitePriceDocsEnterprise
        },
        pricing_workspace: {
          element: site_pricing_workspace_element,
          class: SitePricingWorkSpace
        },
        pricing_docspace: {
          element: site_pricing_docspace_element,
          class: SitePricingDocSpacePrices
        },
        pricing_developer: {
          element: site_pricing_docs_developer_element,
          class: SitePriceDocsDeveloper
        },
        pricing_buy_from_reseller: {
          element: site_pricing_buy_from_reseller_element,
          class: SitePartnersFind
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
          element: site_partners_affiliates_element,
          class: SitePartnersAffiliates
        },
        partners_resellers: {
          element: site_partners_resellers_element,
          class: SitePartnersResellers
        },
        partners_find_partners: {
          element: site_partners_find_partners_element,
          class: SitePartnersFind
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
          class: SiteAboutBlog
        },
        about_forum: {
          element: site_about_forum_element,
          class: SiteAboutForum
        },
        about_contribute: {
          element: site_about_contribute_element,
          class: SiteAboutContribute
        },
        about_customers: {
          element: site_about_customers_element,
          class: SiteAboutCustomerStories
        },
        about_awards: {
          element: site_about_awards_element,
          class: SiteAboutAwards
        },
        about_events: {
          element: site_about_events_element,
          class: SiteAboutEvents
        },
        about_press_downloads: {
          element: site_about_press_downloads_element,
          class: SiteAboutPressDownloads
        },
        about_white_papers: {
          element: site_about_white_papers_element,
          class: SiteAboutWhitePapers
        },
        about_training_courses: {
          element: site_about_training_courses_element,
          class: SiteAboutTrainingCourses
        },
        about_gift_shop: {
          element: site_about_gift_shop_element,
          class: SiteAboutGiftShop
        },
        about_contacts: {
          element: site_about_contacts_element,
          class: SiteAboutContacts
        },
        about_latest_news: {
          element: site_about_latest_news_element
        },
        about_help_center: {
          element: site_about_help_center_element,
          class: SiteAboutHelpCenter
        },
        about_webinars: {
          element: site_about_webinars_element,
          class: SiteAboutWebinars
        },
        about_jobs: {
          element: site_about_jobs_element,
          class: SiteAboutJobs
        }
      }
    end

    def all_toolbar_links_and_classes_hash
      site_toolbar_features.merge(site_toolbar_for_business, site_toolbar_get_onlyoffice, site_toolbar_pricing,
                                  site_toolbar_partners, site_toolbar_about, site_toolbar_for_developers)
    end

    def move_to_element_link_toolbar(section)
      @instance.webdriver.move_to_element_by_locator(site_features_element.selector[:xpath]) if site_toolbar_features.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_for_enterprises_element.selector[:xpath]) if site_toolbar_for_business.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_for_developers_element.selector[:xpath]) if site_toolbar_for_developers.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_get_onlyoffice_element.selector[:xpath]) if site_toolbar_get_onlyoffice.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_pricing_element.selector[:xpath]) if site_toolbar_pricing.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_partners_element.selector[:xpath]) if site_toolbar_partners.key?(section)
      @instance.webdriver.move_to_element_by_locator(site_about_element.selector[:xpath]) if site_toolbar_about.key?(section)
    end

    def click_link_on_toolbar(section)
      move_to_element_link_toolbar(section)
      link = all_toolbar_links_and_classes_hash[section][:element]
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(link) }
      link.click
      @instance.webdriver.switch_to_popup if %i[about_gift_shop about_help_center features_see_it_in_action features_oforms about_blog].include?(section)
      all_toolbar_links_and_classes_hash[section][:class].new(@instance)
    end
  end
end
