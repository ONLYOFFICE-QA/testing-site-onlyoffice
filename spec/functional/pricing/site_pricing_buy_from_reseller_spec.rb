# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Pricing buy from reseller' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_buy_from_reseller = site_home_page.click_link_on_toolbar(:pricing_buy_from_reseller)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Pricing buy from reseller] Go to pricing buy from reseller' do
    expect(@pricing_buy_from_reseller).to be_a TestingSiteOnlyoffice::SitePartnersFind
  end
end
