require 'spec_helper'

describe 'Pricing Cloud Service' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office(config)
    @pricing_cloud_page = site_home_page.click_link_on_toolbar(:pricing_cloud)
  end

  it '[Site][Pricing][Cloud] Click Buy now and check plane on Avangate page' do
    pending('Incorrect pricing users bar https://t.me/c/1440851975/4472') if config.server.include?('info')
    cost = @pricing_cloud_page.get_cost_tarrif_20_year
    avangate_page = @pricing_cloud_page.click_on_buy_now
    expect(avangate_page.get_avangate_current_price_value.to_i).to eq(cost.to_i)
  end

  it '[Site][Pricing][Cloud] Check FAQ link' do
    faq_page = @pricing_cloud_page.click_on_faq_center
    expect(faq_page).to be_a TestingSiteOnlyoffice::SiteFaq
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
