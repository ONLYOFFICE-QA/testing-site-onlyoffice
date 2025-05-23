# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Contains methods for downloading packages
  module SiteDownloadHelper
    def file_downloaded?(file_name)
      path_to_downloaded_file = "#{@instance.webdriver.download_directory}/#{file_name}"
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_file)
      downloaded_file_size = File.size(path_to_downloaded_file)
      downloaded_file_size > if File.extname(file_name) == '.txt'
                               4
                             else
                               100
                             end
    end

    # determines success based on 2xx response code
    # http://www.restapitutorial.com/httpstatuscodes.html
    def link_success_response?(link)
      response = HTTParty.head(link).response.code
      @instance.webdriver.webdriver_error("Link `#{link}` answered with #{response}") unless response.start_with?('2')
      true
    end

    def link_alive?(xpath)
      install_button_element = @instance.webdriver.get_element(xpath)
      link_success_response?(install_button_element.attribute('href'))
    end

    def link_alive_and_valid?(xpath, expected_link, doc_builder: false)
      install_link = if doc_builder
                       @instance.webdriver.get_element(xpath).attribute('data-download')
                     else
                       @instance.webdriver.get_element(xpath).attribute('href')
                     end
      link_success_response?(install_link) && install_link.include?(expected_link)
    end

    def download_link_valid?(xpath, product)
      install_link = @instance.webdriver.get_element(xpath).attribute('href')
      install_link.to_s.include?(valid_href_values[product])
    end

    def valid_href_values
      {
        windows: '.exe',
        ubuntu: '.sh',
        centos: '.sh',
        debian: '.sh',
        docker: '.sh',
        deb: '.deb',
        rpm: '.rpm',
        mac: '.dmg'
      }
    end

    def download_link_alive?(product)
      link_success_response?(download_links[product].attribute('href'))
    end

    def instruction_link_alive?(product)
      link_success_response?(instruction_links[product].attribute('href'))
    end

    def check_opened_page_title(switch_tab: true)
      @instance.webdriver.choose_tab(2) if switch_tab
      sleep 3
      @instance.webdriver.title_of_current_tab
    end

    def check_opened_page_title_and_wait_until_not_empty(switch_tab: true)
      @instance.webdriver.choose_tab(2) if switch_tab
      @instance.webdriver.wait_until { !@instance.webdriver.title_of_current_tab.empty? }
      @instance.webdriver.title_of_current_tab
    end

    def check_opened_file_name
      @instance.webdriver.choose_tab(2)
      @instance.init_online_documents
      @instance.doc_instance.management.wait_for_operation_with_round_status_canvas
      @instance.doc_instance.doc_editor.top_toolbar.title_row.document_name
    end
  end
end
