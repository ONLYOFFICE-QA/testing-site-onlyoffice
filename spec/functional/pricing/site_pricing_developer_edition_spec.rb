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

  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |support_level|
    it "[Site][Pricing][DocsDeveloper] Choose the DocsDeveloper tariff: #{support_level}" do
      @pricing_developers_page.fill_data_pricing_page(support_level)
      total_price = @pricing_developers_page.total_price_number.to_i
      payment_page = @pricing_developers_page.go_to_payment_from_pricing_page(@pricing_developers_page.buy_now_button_element, test_purchase: true)
      expect(payment_page.total_amount_without_tax).to eq(total_price)
    end
  end
end
