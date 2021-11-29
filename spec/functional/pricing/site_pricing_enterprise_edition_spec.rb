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

  it '[Site][PricingDocsEnterprise] Try it free download docs' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    connectors = pricing_page.click_try_free_button
    expect(connectors.page_title).to eq('ONLYOFFICE Docs Enterprise')
  end

  describe 'Choose tariffs docs enterprise' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_docs_enterprise_data[:support_level].each do |support_level|
      it "[Site][PricingDocsEnterprise] Choose the ONLYOFFICE Docs Enterprise Edition tariff: #{support_level}, more connection" do
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
        pricing_page.fill_data_price_enterprise('More', support_level)
        expect(pricing_page.total_price_upon_request).to eq('Upon request')
      end

      TestingSiteOnlyoffice::SiteDownloadData.pricing_docs_enterprise_data[:number_connection].each do |number_connection|
        it "[Site][PricingDocsEnterprise] Choose the ONLYOFFICE Docs Enterprise Edition tariff: #{support_level}, count users: #{number_connection}" do
          pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
          pricing_page.fill_data_price_enterprise(number_connection, support_level)
          total_price = pricing_page.total_price_number.to_i
          avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_single_server_element, test_purchase: true)
          expect(avangate.total_amount_without_tax).to eq(total_price)
        end
      end
    end
  end
end
