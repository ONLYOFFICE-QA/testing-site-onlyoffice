# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site Download data
  class SiteDownloadData
    # Desktop
    def self.desktop_download_list_type
      {
        download_file: %i[macos_x86 debian_8 centos appimage],
        three_download_windows_files: %i[windows_10_8_7_x64 windows_10_8_7_x86 windows_xp],
        two_download_mac_files: %i[macos_10],
        download_from_store: %i[snap flatpak]
      }
    end

    def self.desktop_download_list
      desktop_download_list_type[:download_file] + desktop_download_list_type[:three_download_windows_files] + desktop_download_list_type[:download_from_store] + desktop_download_list_type[:two_download_mac_files]
    end

    def self.desktop_mobile_info
      @desktop_mobile_info ||= JSON.parse(File.read("#{__dir__}/site_desktop_info.json"))
    end

    # Onlyoffice Documents mobile apps
    MOBILE_DOCUMENTS_GOOGLE = 'ONLYOFFICE Documents - Apps on Google Play'
    MOBILE_DOCUMENTS_APP_GALLERY = 'AppGallery'
    MOBILE_DOCUMENTS_GALAXY_STORE = 'ONLYOFFICE Documents'
    MOBILE_DOCUMENTS_APP_STORE = 'ONLYOFFICE Documents on the App Store'
    MOBILE_DOCUMENTS_IOS_CHANGELOG = 'Documents app for iOS changelog - ONLYOFFICE'

    # Onlyoffice Projects mobile apps
    MOBILE_PROJECTS_GOOGLE = 'ONLYOFFICE Projects - Apps on Google Play'
    MOBILE_PROJECTS_APP_GALLERY = 'AppGallery'
    MOBILE_PROJECTS_APP_STORE = 'ONLYOFFICE Projects on the App Store'

    # Onlyoffice API
    EXTERNAL_ACCES_API_ONLYOFFICE_TITLE = 'ONLYOFFICE Api Documentation - External access to the document editing'
    OVERVIEW_API_ONLYOFFICE_TITLE = 'ONLYOFFICE Api Documentation - Overview'
    CONVERSION_API_ONLYOFFICE_TITLE = 'ONLYOFFICE Api Documentation - Conversion API'

    # Onlyoffice on marketplaces
    AWS_MARKETPLACE_TITLE = 'AWS Marketplace: Ascensio Systems Inc'
    ALIBABA_MARKETPLACE_TITLE = 'Ascensio System Ltd. - Alibaba Cloud'

    # Connectors
    def self.connectors_info
      @connectors_info ||= JSON.parse(File.read("#{__dir__}/site_connectors_info.json"))
    end

    # Integrations
    def self.connectors_partners_info
      @connectors_partners_info ||= JSON.parse(File.read("#{__dir__}/site_integrations_info.json"))
    end

    # Open Source Bundles
    def self.open_source_bundles_list_download_type
      {
        download: %i[workspace_windows workspace_deb workspace_rpm workspace_docker_image owncloud_vmware owncloud_vmware_esxi owncloud_virtualbox owncloud_kvm nextcloud_vmware nextcloud_vmware_esxi nextcloud_virtualbox nextcloud_kvm],
        new_tab: %i[workspace_docker_compose workspace_digitalocean owncloud_docker_compose nextcloud_docker_compose]
      }
    end

    def self.open_source_bundles_list
      open_source_bundles_list_download_type[:download] + open_source_bundles_list_download_type[:new_tab]
    end

    def self.open_source_bundler_extensions
      {
        exe: %i[workspace_windows],
        sh: %i[workspace_deb workspace_rpm workspace_docker_image],
        zip: %i[owncloud_vmware nextcloud_vmware],
        ova: %i[owncloud_vmware_esxi owncloud_virtualbox nextcloud_vmware_esxi nextcloud_virtualbox],
        qcow2: %i[owncloud_kvm nextcloud_kvm]
      }
    end

    def self.workspace_community
      %i[workspace_windows workspace_deb workspace_rpm workspace_docker_image workspace_docker_compose workspace_digitalocean]
    end

    def self.other_products_bundles_list
      %i[owncloud_docker_compose owncloud_vmware owncloud_vmware_esxi owncloud_virtualbox owncloud_kvm nextcloud_docker_compose nextcloud_vmware nextcloud_vmware_esxi nextcloud_virtualbox nextcloud_kvm]
    end

    def self.open_source_bundlers_info
      @open_source_bundlers_info ||= JSON.parse(File.read("#{__dir__}/site_open_source_bundles_info.json"))
    end

    # Open Source Groups
    def self.open_source_groups_list
      %i[docker debian centos windows]
    end

    def self.open_source_groups_info
      @open_source_groups_info ||= JSON.parse(File.read("#{__dir__}/site_open_source_groups_info.json"))
    end

    # Open Source Docs
    def self.open_source_docs_list_type
      {
        with_github: %i[docker ubuntu centos windows snap],
        without_github: %i[digitalocean Cloudron UCS]
      }
    end

    def self.open_source_docs_list
      open_source_docs_list_type[:with_github] + open_source_docs_list_type[:without_github]
    end

    def self.open_source_docs_info
      @open_source_docs_info ||= JSON.parse(File.read("#{__dir__}/site_open_source_docs_info.json"))
    end

    # Commercial Workspace
    def self.commercial_workspace_list_type
      {
        with_buy_button: %i[windows docker debian centos],
        without_buy_button: %i[amazon_machine ovhcloud],
        with_instruction: %i[windows docker debian centos amazon_machine]
      }
    end

    def self.commercial_info
      @commercial_info ||= JSON.parse(File.read("#{__dir__}/site_commercial_info.json"))
    end

    def self.commercial_packages_without_download_form
      %i[amazon_machine ovhcloud univention]
    end

    # Commercial Enterprise Docs
    def self.commercial_enterprise_docs_list_type
      {
        with_buy_button: %i[docker debian centos windows],
        without_buy_button: %i[amazon_machine univention],
        with_instruction: %i[windows docker debian centos amazon_machine]
      }
    end

    # Commercial DeveloperDocs
    def self.commercial_developer_docs_list_type
      {
        with_buy_button: %i[docker debian centos windows],
        without_buy_button: %i[amazon_machine],
        with_instruction: %i[docker debian centos windows amazon_machine]
      }
    end

    # Document Builder
    def self.document_builder_list
      %i[windows debian centos]
    end

    def self.document_builder_info
      @document_builder_info ||= JSON.parse(File.read("#{__dir__}/site_document_builder_info.json"))
    end

    def self.pricing_page_data
      {
        support_level: %w[Basic Plus Premium],
        support_level_workspace: %w[basic standard premium],
        number_connection_docspace: %w[100 250 500 1000],
        number_connection_enterprise: %w[50 100 200],
        number_connection_developer: %w[250 500 1000],
        docs_enterprise_license_duration: %w[one_year lifetime],
        docs_enterprise_cloud_type: %w[Business VIP]
      }
    end

    def self.marketplace_plugins_info
      @marketplace_plugins_info ||= JSON.parse(File.read("#{__dir__}/site_marketplace_plugins_info.json"))
    end

    def self.editors_preinstalled_and_available
      @editors_preinstalled_and_available ||= JSON.parse(File.read("#{__dir__}/desktop_editors_preinstalled_and_available.json"))
    end
  end
end
