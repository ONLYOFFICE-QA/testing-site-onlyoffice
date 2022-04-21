# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Alfresco' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @alfresco = site_home_page.click_link_on_toolbar(:integrations_alfresco)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Alfresco] Go to nextcloud' do
    expect(@alfresco).to be_a TestingSiteOnlyoffice::SiteAlfresco
  end

  it '[Alfresco] Go to pick your price' do
    business_price = @alfresco.check_link_pick_your_price
    expect(business_price.check_active_tariff?('business')).to be true
  end

  it '[Alfresco] Go to home tariff' do
    business_price = @alfresco.check_link_home_tariff
    expect(business_price.check_active_tariff?('home')).to be true
  end
end
