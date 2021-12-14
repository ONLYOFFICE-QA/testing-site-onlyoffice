# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Press downloads' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @press_downloads = site_home_page.click_link_on_toolbar(:about_press_downloads)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Press downloads] Go to press downloads' do
    expect(@press_downloads).to be_a TestingSiteOnlyoffice::SiteAboutPressDownloads
  end

  it '[Press downloads] Left menu' do
    expect(@press_downloads.left_menu_list).to eq(TestingSiteOnlyoffice::SiteData.left_menu_about_press_downloads)
  end
end
