# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs developer' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_developers_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][DocsDeveloper] Try it free link works' do
    result_page = @pricing_developers_page.click_free_button
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end
end
