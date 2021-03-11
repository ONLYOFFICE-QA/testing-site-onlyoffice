# frozen_string_literal: true

module TestingSiteOnlyoffice
  class SiteDownloadData
    # Desktop
    DESKTOP_WINDOWS_10_X64 = 'DesktopEditors_x64.exe'
    DESKTOP_WINDOWS_10_X86 = 'DesktopEditors_x86.exe'
    DESKTOP_WINDOWS_XP_X64 = 'DesktopEditors_x64_xp.exe'
    DESKTOP_WINDOWS_XP_X86 = 'DesktopEditors_x86_xp.exe'
    DESKTOP_WINDOWS_INSTRUCTION = 'How to install Desktop Editors for Windows to your computer? - ONLYOFFICE'
    DESKTOP_MACOS = 'ONLYOFFICE.dmg'
    DESKTOP_MACOS_INSTRUCTION = 'How to install ONLYOFFICE Desktop Editors for Mac OS? - ONLYOFFICE'
    DESKTOP_DEBIAN = 'onlyoffice-desktopeditors_amd64.deb'
    DESKTOP_DEB_INSTRUCTION = 'How to install Desktop Editors to Ubuntu and derivatives? - ONLYOFFICE'
    DESKTOP_CENTOS = 'onlyoffice-desktopeditors.x86_64.rpm'
    DESKTOP_RPM_INSTRUCTION = 'How to install Desktop Editors to Red Hat and derivatives? - ONLYOFFICE'
    DESKTOP_APPIMAGE = 'DesktopEditors-x86_64.AppImage'
    DESKTOP_APPIMAGE_INSTRUCTION = 'ONLYOFFICE – AppImageHub'
    DESKTOP_INSTALL_FROM_SNAP = 'Install ONLYOFFICE Desktop Editors for Linux using the Snap Store | Snapcraft'
    DESKTOP_SNAP_INSTRUCTION = 'How to install Desktop Editors from snap package? - ONLYOFFICE'
    DESKTOP_INSTALL_FROM_FLATPAK = 'ONLYOFFICE Desktop Editors—Linux Apps on Flathub'
    DESKTOP_FLATPAK_INSTRUCTION  = 'How to install ONLYOFFICE Desktop Editors for Linux to your computer using Flatpak? - ONLYOFFICE'

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
