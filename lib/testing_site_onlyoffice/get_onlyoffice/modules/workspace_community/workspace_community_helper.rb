# frozen_string_literal: true

require_relative '../site_download_helper'

module TestingSiteOnlyoffice
  # Download helper for /download-workspace.aspx#workspace-community and /download.aspx#bundles pages
  module SiteWorkspaceCommunityHelper
    include PageObject
    include SiteDownloadHelper

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
