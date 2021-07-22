# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
site_home_page, test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)

describe 'Help center top toolbar links' do
  after do |example|
    test_manager.add_result(example, test)
  end

  after(:all) { test.webdriver.quit }

  site_home_page.all_toolbar_links_and_classes_hash.each do |toolbar_item_data|
    it "[Site] `#{toolbar_item_data[0]}` link of top toolbar works" do
      toolbar_element = toolbar_item_data[1][:element]
      expect(site_home_page).to be_link_success_response(toolbar_element.attribute('href'))
    end
  end
end
