# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs developer' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][PricingDocsDeveloper] Try it free download docs' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
    connectors = pricing_page.click_free_button
    expect(connectors.page_title).to eq('ONLYOFFICE Docs Developer')
  end

  describe 'Choose tariffs docs developer' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |support_level|
      it "[Site][PricingDocsDeveloper] Choose the ONLYOFFICE Docs Developer Edition tariff: #{support_level}, more connection" do
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
        pricing_page.fill_data_price_developer('More', support_level)
        expect(pricing_page).to be_button_get_quote_present
      end

      TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:number_connection_developer].each do |number_connection|
        it "[Site][PricingDocsEnterprise] Choose the ONLYOFFICE Docs Developer Edition tariff: #{support_level}, count users: #{number_connection}" do
          pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
          pricing_page.fill_data_price_developer(number_connection, support_level)
          expect(pricing_page).to be_button_get_quote_present
        end
      end
    end
  end
end
