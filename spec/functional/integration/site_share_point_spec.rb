# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'SiteSharePoint' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @sharepoint = site_home_page.click_link_on_toolbar(:integrations_sharepoint)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[SiteSharePoint] Go to SiteSharePoint' do
    expect(@sharepoint).to be_a TestingSiteOnlyoffice::SiteSharePoint
  end

  it '[SiteSharePoint] Go to pick your price' do
    business_price = @sharepoint.check_link_pick_your_price
    expect(business_price.check_active_tariff?('business')).to be true
  end

  it '[SiteSharePoint] Go to home tariff' do
    business_price = @sharepoint.check_link_home_tariff
    expect(business_price.check_active_tariff?('home')).to be true
  end
end
