# Top toolbar
# https://user-images.githubusercontent.com/40513035/95858305-90f89400-0d65-11eb-95a1-3aa66b1258d0.png
require_relative 'site_languages'
require_relative 'additional_methods/forgot_password_helper'

module TestingSiteOnlyoffice
  module SiteToolbar
    include PageObject
    include SiteLanguages
    include ForgotPasswordHelper

    link(:logo_home, xpath: '//header//div[contains(@class, "logo")]//a')

    # top toolbar - Solutions
    link(:site_solutions, xpath: '//a[@id="navitem_solutions"]')
    link(:site_solutions_smbs, xpath: '//a[@id="navitem_solutions_smbs"]')
    link(:site_solutions_enterprises, xpath: '//a[@id="navitem_solutions_enterprises"]')
    link(:site_solutions_developers, xpath: '//a[@id="navitem_solutions_developers"]')
    link(:site_solutions_hosting, xpath: '//a[@id="navitem_solutions_hosting"]')
    link(:site_solutions_government, xpath: '//*[@id="navitem_solutions_government"]')
    link(:site_solutions_healthcare, xpath: '//a[@id="navitem_solutions_healthcare"]')
    link(:site_solutions_research, xpath: '//a[@id="navitem_solutions_research"]')
    link(:site_solutions_education, xpath: '//a[@id="navitem_solutions_education"]')
    link(:site_solutions_nonprofit, xpath: '//a[@id="navitem_solutions_nonprofit"]')
    link(:site_solutions_home_use, xpath: '//a[@id="navitem_solutions_home_use"]')

    # top toolbar - Products
    link(:site_products, xpath: '//a[@id="navitem_features"]')
    link(:site_products_workspace, xpath: '//a[@id="navitem_solutions_clients_workspace"]')
    link(:site_products_editors, xpath: '//a[@id="navitem_features_editors"]')
    link(:site_products_editors_documents, xpath: '//a[@id="navitem_features_document_editor"]')
    link(:site_products_editors_spreadsheet, xpath: '//a[@id="navitem_features_spreadsheet_editor"]')
    link(:site_products_editors_presentation, xpath: '//a[@id="navitem_features_presentation_editor"]')
    link(:site_products_for_desktop, xpath: '//a[@id="navitem_solutions_clients_apps"]')
    link(:site_products_for_ios, xpath: '//a[@id="navitem_solutions_clients_mobile_ios"]')
    link(:site_products_for_android, xpath: '//a[@id="navitem_solutions_clients_mobile_android"]')
    link(:site_products_groups, xpath: '//a[@id="navitem_features_comserver"]')
    link(:site_products_groups_documents, xpath: '//a[@id="navitem_features_documents"]')
    link(:site_products_groups_mail, xpath: '//a[@id="navitem_features_mail"]')
    link(:site_products_groups_crm, xpath: '//a[@id="navitem_features_crm"]')
    link(:site_products_groups_projects, xpath: '//a[@id="navitem_features_projects"]')
    link(:site_products_groups_calendar, xpath: '//a[@id="navitem_features_calendar"]')
    link(:site_products_groups_community, xpath: '//a[@id="navitem_features_network"]')
    link(:site_products_security, xpath: '//a[@id="navitem_features_security"]')

    # top toolbar - Pricing
    link(:site_pricing, xpath: '//a[@id="navitem_prices"]')
    link(:site_pricing_docs_enterprise, xpath: '//a[@id="navitem_prices_server_enterprice"]')
    link(:site_pricing_docs_developer, xpath: '//a[@id="navitem_prices_integration"]')
    link(:site_pricing_workspace_cloud, xpath: '//a[@id="navitem_prices_saas"]')
    link(:site_pricing_workspace_server, xpath: '//a[@id="navitem_prices_enterprise"]')

    # top toolbar - Get Onlyoffice
    link(:site_get_onlyoffice, xpath: '//a[@id="navitem_download"]')
    link(:site_get_onlyoffice_sign_in, xpath: '//a[@id="navitem_download_signin"]')
    link(:site_get_onlyoffice_sign_up, xpath: '//a[@id="navitem_download_signup"]')
    link(:site_get_onlyoffice_open_source, xpath: '//a[@id="navitem_download_connectors"]')
    link(:site_get_onlyoffice_commercial, xpath: '//a[@id="navitem_download_commercial"]')
    link(:site_get_onlyoffice_desktop_mobile, xpath: '//a[@id="navitem_download_desktop"]')

    # top toolbar - Partners
    link(:site_partners, xpath: '//a[@id="navitem_partners"]')
    link(:site_partners_affiliates, xpath: '//a[@id="navitem_hosters"]')
    link(:site_partners_resellers, xpath: '//a[@id="navitem_resellers"]')
    link(:site_partners_find, xpath: '//a[@id="navitem_find_partners"]')
    link(:site_partners_submit_request, xpath: '//a[@id="navitem_submit_request"]')

    # top toolbar - About
    link(:site_about, xpath: '//a[@id="navitem_about"]')
    link(:site_about_about_onlyoffice, xpath: '//a[@id="navitem_about_about"]')
    link(:site_about_blog, xpath: '//a[@id="navitem_about_blog"]')
    link(:site_about_contribute, xpath: '//a[@id="navitem_about_contribute"]')
    link(:site_about_customers, xpath: '//a[@id="navitem_about_customers"]')
    link(:site_about_awards, xpath: '//a[@id="navitem_about_awards"]')
    link(:site_about_events, xpath: '//a[@id="navitem_about_events"]')
    link(:site_about_press_downloads, xpath: '//a[@id="navitem_about_pressdownloads"]')
    link(:site_about_gift_shop, xpath: '//a[@id="navitem_about_giftshop"]')
    link(:site_about_contacts, xpath: '//a[@id="navitem_about_contacts"]')

    def click_home_logo
      logo_home_element.click
      SiteHomePage.new(@instance)
    end

    def site_toolbar_solutions
      {
        home_use: {
          element: site_solutions_home_use_element,
          class: SiteHomeUse
        },
        nonprofits: {
          element: site_solutions_nonprofit_element,
          class: SiteNonProfits
        }
      }
    end

    def site_toolbar_products
      {
        products_workspace: {
          element: site_products_workspace_element,
          class: SiteProductsWorkspace
        },
        products_docs: {
          element: site_products_editors_element,
          class: SiteProductsDocs
        },
        products_document_editor: {
          element: site_products_editors_documents_element,
          class: SiteProductsDocumentEditor
        },
        products_spreadsheet_editor: {
          element: site_products_editors_spreadsheet_element,
          class: SiteProductsSpreadsheetEditor
        },
        products_presentation_editor: {
          element: site_products_editors_presentation_element,
          class: SiteProductsPresentationEditor
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
        products_groups: {
          element: site_products_groups_element,
          class: SiteProductsGroups
        },
        products_doc_manager: {
          element: site_products_groups_documents_element,
          class: SiteProductsDocumentManager
        },
        products_mail: {
          element: site_products_groups_mail_element,
          class: SiteProductsMail
        },
        products_crm: {
          element: site_products_groups_crm_element,
          class: SiteProductsCRM
        },
        products_projects: {
          element: site_products_groups_projects_element,
          class: SiteProductsProjects
        },
        products_calendar: {
          element: site_products_groups_calendar_element,
          class: SiteProductsCalendar
        },
        products_community: {
          element: site_products_groups_community_element,
          class: SiteProductsCommunity
        },
        security: {
          element: site_products_security_element,
          class: SiteProductsSecurity
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
        open_source_packages: {
          element: site_get_onlyoffice_open_source_element,
          class: SiteOpenSourceDocs
        },
        commercial_packages: {
          element: site_get_onlyoffice_commercial_element,
          class: SiteCommercialDocs
        },
        desktop_mobile_apps: {
          element: site_get_onlyoffice_desktop_mobile_element,
          class: SiteDesktopApps
        }
      }
    end

    def site_toolbar_partners
      {
        submit_request: {
          element: site_partners_submit_request_element,
          class: SitePartnersRequest
        }
      }
    end

    def site_toolbar_about
      {
        about_onlyoffice: {
          element: site_about_about_onlyoffice_element,
          class: SiteAbout
        },
        blog: {
          element: site_about_blog_element,
          class: SiteBlog
        }
      }
    end

    def all_toolbar_links_and_classes_hash
      site_toolbar_solutions.merge(site_toolbar_products, site_toolbar_get_onlyoffice, site_toolbar_pricing,
                                   site_toolbar_partners, site_toolbar_about)
    end

    def click_link_on_toolbar(section)
      if site_toolbar_solutions.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_solutions_element.selector[:xpath])
      end
      if site_toolbar_products.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_products_element.selector[:xpath])
      end
      if site_toolbar_get_onlyoffice.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_get_onlyoffice_element.selector[:xpath])
      end
      if site_toolbar_pricing.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_pricing_element.selector[:xpath])
      end
      if site_toolbar_partners.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_partners_element.selector[:xpath])
      end
      if site_toolbar_about.key?(section)
        @instance.webdriver.move_to_element_by_locator(site_about_element.selector[:xpath])
      end
      link = all_toolbar_links_and_classes_hash[section][:element]
      @instance.webdriver.wait_until { link.present? }
      link.click
      all_toolbar_links_and_classes_hash[section][:class].new(@instance)
    end

    def send_forgot_password_from_sign_in(email = mail_for_forgotten_password.username)
      sign_in = click_link_on_toolbar(:sign_in)
      sign_in.send_forgot_password(email)
    end
  end
end
