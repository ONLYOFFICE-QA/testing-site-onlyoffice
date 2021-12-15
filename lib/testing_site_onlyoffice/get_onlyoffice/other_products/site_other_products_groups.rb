# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative 'modules/other_products_toolbar'
require_relative '../modules/site_download_helper'

module TestingSiteOnlyoffice
  # /download.aspx#groups
  # https://user-images.githubusercontent.com/40513035/131140675-36b7a7dc-f6a9-42bb-a2e9-36ff178349bc.png
  class SiteOtherProductsGroups
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteOtherProductsToolbar

    groups_instruction_docker = "//a[contains(@href, 'groups-install-docker')]"
    link(:site_open_source_groups_docker_download,
         xpath: "#{groups_instruction_docker}/../../..//a[contains(@href, 'groups-install.sh')]")
    link(:site_open_source_groups_docker_instruction, xpath: groups_instruction_docker)
    link(:site_open_source_groups_docker_github,
         xpath: "#{groups_instruction_docker}/../../p/a[contains(@href, 'Docker-CommunityServer')]")

    groups_instruction_debian = "//a[contains(@href, 'groups-install-ubuntu')]"
    link(:site_open_source_groups_debian_download,
         xpath: "#{groups_instruction_debian}/../../..//a[contains(@href, 'groups-install.sh')]")
    link(:site_open_source_groups_debian_instruction, xpath: groups_instruction_debian)
    link(:site_open_source_groups_debian_github,
         xpath: "#{groups_instruction_debian}/../../p/a[contains(@href, 'CommunityServer')]")

    groups_instruction_centos = "//a[contains(@href, 'groups-install-centos')]"
    link(:site_open_source_groups_centos_download,
         xpath: "#{groups_instruction_centos}/../../..//a[contains(@href, 'groups-install.sh')]")
    link(:site_open_source_groups_centos_instruction, xpath: groups_instruction_centos)
    link(:site_open_source_groups_centos_github,
         xpath: "#{groups_instruction_centos}/../../p/a[contains(@href, 'CommunityServer')]")

    groups_instruction_windows = "//a[contains(@href, 'groups-install-windows')]"
    link(:site_open_source_groups_windows_download, xpath: "//a[contains(@href, 'Groups_Win-install.latest.exe')]")
    link(:site_open_source_groups_windows_instruction, xpath: groups_instruction_windows)
    link(:site_open_source_groups_windows_github,
         xpath: "#{groups_instruction_windows}/../../p/a[contains(@href, 'CommunityServer')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(site_open_source_groups_docker_download_element)
      end
    end

    def download_links
      {
        docker: site_open_source_groups_docker_download_element,
        debian: site_open_source_groups_debian_download_element,
        centos: site_open_source_groups_centos_download_element,
        windows: site_open_source_groups_windows_download_element
      }
    end

    def instruction_links
      {
        docker: site_open_source_groups_docker_instruction_element,
        debian: site_open_source_groups_debian_instruction_element,
        centos: site_open_source_groups_centos_instruction_element,
        windows: site_open_source_groups_windows_instruction_element
      }
    end

    def github_links
      {
        docker: site_open_source_groups_docker_github_element,
        debian: site_open_source_groups_debian_github_element,
        centos: site_open_source_groups_centos_github_element,
        windows: site_open_source_groups_windows_github_element
      }
    end

    def click_groups_github_link(installer)
      github_links[installer].click
    end

    def click_groups_instruction_link(installer)
      instruction_links[installer].click
    end

    def download_xpath(installer)
      download_links[installer].selector[:xpath]
    end
  end
end
