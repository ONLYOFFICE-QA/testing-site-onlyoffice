# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Products Marketplace' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @marketplace_page = site_home_page.click_link_on_toolbar(:features_marketplace)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  TestingSiteOnlyoffice::SiteDownloadData.marketplace_plugins_info.each_key do |plugin|
    describe plugin.to_s do
      it "[Site][Products][Marketplace][#{plugin}] 'Get it now' link works" do
        plugin_info = @marketplace_page.click_get_it_now(plugin)
        expected_title = TestingSiteOnlyoffice::SiteDownloadData.marketplace_plugins_info[plugin]['get_it_now_title']
        expect(plugin_info.current_plugin_page_title).to eq(expected_title)
      end
    end
  end

  it '[Site][Products][Marketplace] Search for plugin works' do
    plugin_to_search = TestingSiteOnlyoffice::SiteDownloadData.marketplace_plugins_info.keys.first.to_s
    plugin_search_successful = @marketplace_page.search_for_plugin_works?(plugin_to_search)
    expect(plugin_search_successful).to be_truthy
  end

  it "[Site][Products][Marketplace] 'Visit API' button works" do
    @marketplace_page.click_visit_api_button
    expected_title = 'ONLYOFFICE'
    expect(@marketplace_page.check_opened_page_title).to eq(expected_title)
  end

  it "[Site][Products][Marketplace] Plugins number didn't change" do
    expect(@marketplace_page.plugins_count).to eq(TestingSiteOnlyoffice::SiteDownloadData.marketplace_plugins_info.keys.count)
  end
end
