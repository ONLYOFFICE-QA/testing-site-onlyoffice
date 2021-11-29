# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Pricing Developer Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @developer_edition_prices = site_home_page.click_link_on_toolbar(:pricing_developer)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe '#developer_saas_server' do
    it '[Pricing][Developer Edition][Single Server] `250 - 500 - 1000 - 500 - 250` check connections switcher /developer-edition-prices.aspx' do
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(250)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_250)
      @developer_edition_prices.increase_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(500)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_500)
      @developer_edition_prices.increase_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(1000)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_1000)
      # shouldn't go upper top border
      @developer_edition_prices.increase_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(1000)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_1000)
      @developer_edition_prices.decrease_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(500)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_500)
      @developer_edition_prices.decrease_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(250)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_250)
      # shouldn't go lower bottom border
      @developer_edition_prices.decrease_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(250)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_250)
    end

    it '[Pricing][Developer Edition][SaaS Server] Prices on store.onlyoffice.com and onlyoffice.com are the same for 250 connections' do
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(250)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_250)
      avangate = @developer_edition_prices.click_buy_now_single_server
      value = avangate.current_price
      avangate_price = avangate.get_avangate_value(value).to_i
      expect(avangate_price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_250)
    end

    it '[Pricing][Developer Edition][Single Server] Prices on store.onlyoffice.com and onlyoffice.com are the same for 500 connections' do
      @developer_edition_prices.increase_single_server_connections_num
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(500)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_500)
      avangate = @developer_edition_prices.click_buy_now_single_server
      value = avangate.current_price
      avangate_price = avangate.get_avangate_value(value).to_i
      expect(avangate_price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_500)
    end

    it '[Pricing][Developer Edition][Single Server] Prices on store.onlyoffice.com and onlyoffice.com are the same for 1000 connections' do
      2.times { @developer_edition_prices.increase_single_server_connections_num }
      price, connections_num = @developer_edition_prices.current_single_server_price
      expect(connections_num).to eq(1000)
      expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_1000)
      avangate = @developer_edition_prices.click_buy_now_single_server
      value = avangate.current_price
      avangate_price = avangate.get_avangate_value(value).to_i
      expect(avangate_price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_single_server_1000)
    end
  end

  it '[Pricing][Developer Edition][Development Server] Prices on store.onlyoffice.com and onlyoffice.com are the same for 20 connections' do
    price, connections_num = @developer_edition_prices.current_development_server_price
    expect(connections_num).to eq(20)
    expect(price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_developer_server)
    avangate = @developer_edition_prices.click_buy_now_development_server
    value = avangate.current_price
    avangate_price = avangate.get_avangate_value(value).to_i
    expect(avangate_price).to eq(TestingSiteOnlyoffice::SitePricesData.developer_edition_developer_server)
  end

  it '[Pricing][Developer Edition][Cluster] Cluster prices contains only link to email' do
    expect(@developer_edition_prices.cluster_quote_email).to eq('mailto:sales@onlyoffice.com')
  end
end
