# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs enterprise' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][DocsEnterprise] Try it free download docs' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    connectors = pricing_page.click_try_free_button
    expect(connectors.page_title).to eq('ONLYOFFICE Docs Enterprise')
  end

  it '[Site][Pricing][DocsEnterprise] Home use buy' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    pricing_page.choose_home_tariff
    total_price = pricing_page.total_price_home_use.to_i
    payment_page = pricing_page.go_to_payment_from_pricing_page(pricing_page.buy_home_server_element, test_purchase: true)
    expect(payment_page).to be_payment_page_opened
    expect(payment_page.total_amount_without_tax).to eq(total_price)
  end

  it_behaves_like 'pricing_buy_page', 'PricingDocsEnterprise',
                  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level],
                  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:number_connection_enterprise] do
    let(:pricing_page) { @site_home_page.click_link_on_toolbar(:pricing_enterprise) }
  end
end
