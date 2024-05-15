# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
site_home_page, test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
toolbar_links = site_home_page.all_toolbar_links_and_classes_hash
test.webdriver.quit

describe 'Site top toolbar links' do
  before do
    site_home_page, test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, test)
    test.webdriver.quit
  end

  toolbar_links.each do |toolbar_item_data|
    it "[Site] `#{toolbar_item_data[0]}` link of top toolbar works" do
      element_xpath = toolbar_item_data[1][:element].selector[:xpath]
      href = site_home_page.instance.webdriver.get_attribute(element_xpath, 'href')
      expect(site_home_page).to be_link_success_response(href)
    end
  end
end
