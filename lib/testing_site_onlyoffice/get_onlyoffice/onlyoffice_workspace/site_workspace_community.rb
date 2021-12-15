# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'modules/onlyoffice_workspace_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../modules/open_source/site_installer_block_constructor'
require_relative '../modules/workspace_community/workspace_community_helper'

module TestingSiteOnlyoffice
  # /download-workspace.aspx#workspace-community
  # https://user-images.githubusercontent.com/40513035/131102482-ae967b0e-8be3-4ce1-98cf-c5b8faeeb51d.png
  class SiteWorkspaceCommunity
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarOnlyofficeWorkspace
    include SiteWorkspaceCommunityHelper

    bundle_download_windows = '//a[contains(@href, "Workspace_Win")]'
    link(:site_open_source_bundles_windows, xpath: bundle_download_windows)
    link(:site_open_source_bundles_windows_instruction,
         xpath: "#{bundle_download_windows}/../../div/p/a[contains(@href, 'windows.aspx')]")

    download_deb_element = "//div[contains(@class, 'workspace-community')]//h4[contains(text(), 'Debian')]/../div"
    link(:site_open_source_bundles_deb, xpath: "#{download_deb_element}/a[contains(@href, 'workspace-install.sh')]")
    link(:site_open_source_bundles_deb_instruction, xpath: "#{download_deb_element}/p/a[contains(@href, 'linux')]")

    download_rpm_element = "//div[contains(@class, 'workspace-community')]//h4[contains(text(), 'CentOS')]/../div"
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

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(site_open_source_bundles_windows_element)
      end
    end

    def download_links
      {
        workspace_windows: site_open_source_bundles_windows_element,
        workspace_deb: site_open_source_bundles_deb_element,
        workspace_rpm: site_open_source_bundles_rpm_element,
        workspace_docker_image: site_open_source_bundles_docker_image_element,
        workspace_docker_compose: site_open_source_bundles_docker_compose_element,
        workspace_digitalocean: site_open_source_bundles_digitalocean_element
      }
    end

    def instruction_links
      {
        workspace_windows: site_open_source_bundles_windows_instruction_element,
        workspace_deb: site_open_source_bundles_deb_instruction_element,
        workspace_rpm: site_open_source_bundles_rpm_instruction_element,
        workspace_docker_image: site_open_source_bundles_docker_image_instruction_element,
        workspace_docker_compose: site_open_source_bundles_docker_compose_instruction_element,
        workspace_digitalocean: site_open_source_bundles_digitalocean_instruction_element
      }
    end
  end
end
