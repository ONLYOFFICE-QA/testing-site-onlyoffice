# frozen_string_literal: true

module TestingSiteOnlyoffice
  class SiteDownloadData
    # Desktop
    def self.desktop_download_list_type
      {
        download_file: %i[macos_10 macos_x86 debian_8 debian_7 centos appimage],
        two_download_files: %i[windows_10 windows_xp],
        download_from_store: %i[snap flatpak]
      }
    end

    def self.desktop_download_list
      desktop_download_list_type[:download_file] + desktop_download_list_type[:two_download_files] + desktop_download_list_type[:download_from_store]
    end

    def self.desktop_mobile_info
      @desktop_mobile_info ||= JSON.parse(File.read("#{__dir__}/site_desktop_info.json"))
    end

    # Mobile
    MOBILE_GOOGLE = 'ONLYOFFICE Documents - Apps on Google Play'
    MOBILE_APP_STORE = '‎ONLYOFFICE Documents on the App Store'
    MOBILE_IOS_CHANGELOG = 'Documents app for iOS changelog - ONLYOFFICE'

    # Connectors
    def self.connectors_list
      %i[alfresco confluence humhub liferay nextcloud nuxeo owncloud plone sharepoint]
    end

    def self.connectors_info
      @connectors_info ||= JSON.parse(File.read("#{__dir__}/site_connectors_info.json"))
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

    DOCUMENT_BUILDER_INSTRUCTION = 'ONLYOFFICE Api Documentation - Getting started'
    DOCUMENT_BUILDER_CHANGELOG = 'DocumentBuilder/CHANGELOG.md at master · ONLYOFFICE/DocumentBuilder · GitHub'
    FORK_ME_ON_GITHUB = 'GitHub - ONLYOFFICE/DocumentBuilder: ONLYOFFICE Document Builder is powerful text, spreadsheet, presentation and PDF generating tool'
  end
end
