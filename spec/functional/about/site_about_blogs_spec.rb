# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Training courses' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_blogs_page = site_home_page.click_link_on_toolbar(:about_blog)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Training courses] Number of modules didn't change" do
    expect(@about_blogs_page.desktop_and_mobile_app).to eq(TestingSiteOnlyoffice::SiteData.blogs_download_app)
  end
end
