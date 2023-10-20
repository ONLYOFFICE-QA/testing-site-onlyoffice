# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing WorkSpace' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][WorkSpace] Check "Try it for free 30 days" link' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_workspace)
    workspace_download_page = pricing_page.click_try_free
    expect(workspace_download_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeWorkspaceEnterprise
  end

  TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level_workspace].each do |support_level|
    it "[Site][Pricing][WorkSpace] Choose the WorkSpace tariff: #{support_level}, more connection" do
      pricing_page = @site_home_page.click_link_on_toolbar(:pricing_workspace)
      pricing_page.add_user_number('More', support_level)
      expect(pricing_page.total_price_upon_request(support_level)).to eq('Upon request')
      expect(pricing_page).to be_button_get_quote_present(support_level)
    end

    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:number_connection_enterprise].each do |number_connection|
      it "[Site][Pricing][WorkSpace] Choose WorkSpace tariff: #{support_level.upcase}, count users: #{number_connection}" do
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_workspace)
        pricing_page.add_user_number(number_connection, support_level)
        total_price = pricing_page.total_price_sum(support_level).to_i
        payment_page = pricing_page.go_to_payment_from_pricing_page(pricing_page.buy_now_button(support_level), test_purchase: true)
        expect(payment_page.total_amount_without_tax).to eq(total_price)
      end
    end
  end
end
