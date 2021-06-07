# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'modules/site_open_source_toolbar'
require_relative '../modules/site_download_helper'

module TestingSiteOnlyoffice
  # Open Source Bundles
  # https://user-images.githubusercontent.com/40513035/97213564-d049ca80-17d2-11eb-9c9d-fffac028177d.png
  class SiteOpenSourceBundles
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarOpenSource

    bundle_download_windows = '//a[contains(@href, "Workspace_Win")]'
    link(:site_open_source_bundles_windows, xpath: bundle_download_windows)
    link(:site_open_source_bundles_windows_instruction,
         xpath: "#{bundle_download_windows}/../../div/p/a[contains(@href, 'windows.aspx')]")

    download_deb_element = "//h4[contains(text(), 'Debian')]/../div"
    link(:site_open_source_bundles_deb, xpath: "#{download_deb_element}/a[contains(@href, 'workspace-install.sh')]")
    link(:site_open_source_bundles_deb_instruction, xpath: "#{download_deb_element}/p/a[contains(@href, 'linux')]")

    download_rpm_element = "//h4[contains(text(), 'CentOS')]/../div"
    link(:site_open_source_bundles_rpm, xpath: "#{download_rpm_element}/a[contains(@href, 'workspace-install.sh')]")
    link(:site_open_source_bundles_rpm_instruction, xpath: "#{download_rpm_element}/p/a[contains(@href, 'linux')]")

    link(:site_open_source_bundles_docker_image,
         xpath: "//h4[contains(text(), 'Docker')]/../div/a[contains(@href, 'workspace-install.sh')]")
    link(:site_open_source_bundles_docker_image_instruction,
         xpath: "//a[contains(@href, 'workspace-install-docker.aspx')]")

    bundles_docker_compose_instruction = "//a[contains(@href, 'workspace-install-docker-compose.aspx')]"
    link(:site_open_source_bundles_docker_compose,
         xpath: "#{bundles_docker_compose_instruction}/../../../div/a[contains(@href, 'Docker')]")
    link(:site_open_source_bundles_docker_compose_instruction, xpath: bundles_docker_compose_instruction)

    download_digitalocean_instruction = '//a[contains(@href, "workspace-install-digitalocean")]'
    link(:site_open_source_bundles_digitalocean,
         xpath: "#{download_digitalocean_instruction}/../../../div/a[contains(@href, 'digitalocean')]")
    link(:site_open_source_bundles_digitalocean_instruction, xpath: download_digitalocean_instruction)

    link(:site_owncloud_docker_compose, xpath: "//a[contains(@href, 'docker-onlyoffice-owncloud')]")
    link(:site_owncloud_docker_compose_instruction, xpath: "//a[contains(@href, 'ownCloudUsingDocker')]")

    owncloud_vmware_download = "//a[contains(@href, 'owncloud-vmware')]"
    link(:site_owncloud_vmware, xpath: owncloud_vmware_download)
    link(:site_owncloud_vmware_instruction,
         xpath: "#{owncloud_vmware_download}/../../div/p/a[contains(@href, 'ownCloudUsingUCS')]")

    owncloud_vmware_esxi_download = "//a[contains(@href, 'owncloud-ESX')]"
    link(:site_owncloud_vmware_esxi, xpath: owncloud_vmware_esxi_download)
    link(:site_owncloud_vmware_esxi_instruction,
         xpath: "#{owncloud_vmware_esxi_download}/../../div/p/a[contains(@href, 'ownCloudUsingUCS')]")

    owncloud_virtualbox_download = "//a[contains(@href, 'owncloud-virtualbox')]"
    link(:site_owncloud_virtualbox, xpath: owncloud_virtualbox_download)
    link(:site_owncloud_virtualbox_instruction,
         xpath: "#{owncloud_virtualbox_download}/../../div/p/a[contains(@href, 'ownCloudUsingUCS')]")

    owncloud_kvm_download = "//a[contains(@href, 'owncloud-KVM')]"
    link(:site_owncloud_kvm, xpath: owncloud_kvm_download)
    link(:site_owncloud_kvm_instruction,
         xpath: "#{owncloud_kvm_download}/../../div/p/a[contains(@href, 'ownCloudUsingUCS')]")

    link(:site_nextcloud_docker_compose, xpath: "//a[contains(@href, 'docker-onlyoffice-nextcloud')]")
    link(:site_nextcloud_docker_compose_instruction, xpath: "//a[contains(@href, 'NextcloudUsingDocker')]")

    nextcloud_vmware_download = "//a[contains(@href, 'nextcloud-vmware')]"
    link(:site_nextcloud_vmware, xpath: nextcloud_vmware_download)
    link(:site_nextcloud_vmware_instruction,
         xpath: "#{nextcloud_vmware_download}/../../div/p/a[contains(@href, 'NextcloudUsingUCS')]")

    nextcloud_vmware_esxi_download = "//a[contains(@href, 'nextcloud-ESX')]"
    link(:site_nextcloud_vmware_esxi, xpath: nextcloud_vmware_esxi_download)
    link(:site_nextcloud_vmware_esxi_instruction,
         xpath: "#{nextcloud_vmware_esxi_download}/../../div/p/a[contains(@href, 'NextcloudUsingUCS')]")

    nextcloud_virtualbox_download = "//a[contains(@href, 'nextcloud-virtualbox')]"
    link(:site_nextcloud_virtualbox, xpath: nextcloud_virtualbox_download)
    link(:site_nextcloud_virtualbox_instruction,
         xpath: "#{nextcloud_virtualbox_download}/../../div/p/a[contains(@href, 'NextcloudUsingUCS')]")

    nextcloud_kvm_download = "//a[contains(@href, 'nextcloud-KVM')]"
    link(:site_nextcloud_kvm, xpath: nextcloud_kvm_download)
    link(:site_nextcloud_kvm_instruction,
         xpath: "#{nextcloud_kvm_download}/../../div/p/a[contains(@href, 'NextcloudUsingUCS')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        site_open_source_bundles_windows_element.present?
      end
    end

    def download_links
      {
        workspace_windows: site_open_source_bundles_windows_element,
        workspace_deb: site_open_source_bundles_deb_element,
        workspace_rpm: site_open_source_bundles_rpm_element,
        workspace_docker_image: site_open_source_bundles_docker_image_element,
        workspace_docker_compose: site_open_source_bundles_docker_compose_element,
        workspace_digitalocean: site_open_source_bundles_digitalocean_element,
        owncloud_docker_compose: site_owncloud_docker_compose_element,
        owncloud_vmware: site_owncloud_vmware_element,
        owncloud_vmware_esxi: site_owncloud_vmware_esxi_element,
        owncloud_virtualbox: site_owncloud_virtualbox_element,
        owncloud_kvm: site_owncloud_kvm_element,
        nextcloud_docker_compose: site_nextcloud_docker_compose_element,
        nextcloud_vmware: site_nextcloud_vmware_element,
        nextcloud_vmware_esxi: site_nextcloud_vmware_esxi_element,
        nextcloud_virtualbox: site_nextcloud_virtualbox_element,
        nextcloud_kvm: site_nextcloud_kvm_element
      }
    end

    def instruction_links
      {
        workspace_windows: site_open_source_bundles_windows_instruction_element,
        workspace_deb: site_open_source_bundles_deb_instruction_element,
        workspace_rpm: site_open_source_bundles_rpm_instruction_element,
        workspace_docker_image: site_open_source_bundles_docker_image_instruction_element,
        workspace_docker_compose: site_open_source_bundles_docker_compose_instruction_element,
        workspace_digitalocean: site_open_source_bundles_digitalocean_instruction_element,
        owncloud_docker_compose: site_owncloud_docker_compose_instruction_element,
        owncloud_vmware: site_owncloud_vmware_instruction_element,
        owncloud_vmware_esxi: site_owncloud_vmware_esxi_instruction_element,
        owncloud_virtualbox: site_owncloud_virtualbox_instruction_element,
        owncloud_kvm: site_owncloud_kvm_instruction_element,
        nextcloud_docker_compose: site_nextcloud_docker_compose_instruction_element,
        nextcloud_vmware: site_nextcloud_vmware_instruction_element,
        nextcloud_vmware_esxi: site_nextcloud_vmware_esxi_instruction_element,
        nextcloud_virtualbox: site_nextcloud_virtualbox_instruction_element,
        nextcloud_kvm: site_nextcloud_kvm_instruction_element
      }
    end

    def click_download_link(installer)
      download_links[installer].click
    end

    def read_instruction_connector(installer)
      instruction_links[installer].click
    end

    def get_bundler_extension(installer)
      SiteDownloadData.open_source_bundler_extensions.each { |key, value| return key if value.include?(installer) }
    end

    def get_download_link(installer)
      xpath = download_links[installer].selector[:xpath]
      @instance.webdriver.get_element(xpath).attribute('href')
    end

    def file_can_be_downloaded?(installer)
      if SiteDownloadData.open_source_bundles_list_download_type[:download].include?(installer)
        installer_extension = get_bundler_extension(installer).to_s
        get_download_link(installer).include?(installer_extension) && download_link_alive?(installer)
      elsif SiteDownloadData.open_source_bundles_list_download_type[:new_tab].include?(installer)
        click_download_link(installer)
        download_page_title = SiteDownloadData.open_source_bundlers_info[installer.to_s]['download']
        @instance.webdriver.wait_until { !check_opened_page_title.empty? } # Digitalocean title loading timeout
        check_opened_page_title == download_page_title
      end
    end
  end
end
