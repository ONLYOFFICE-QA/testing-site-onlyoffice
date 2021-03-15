require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Banners' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
    non_profit_organizatins_page = site_home_page.click_link_on_toolbar(:nonprofits)
    @non_profit_banners = non_profit_organizatins_page.click_request_free_cloud.open_banners
  end

  it '[Site][Banners] switch banner size to 125x125 and verify code /banners.aspx' do
    expect(@non_profit_banners.switch_banner_to_size_works?(:size_125x125)).to be true
  end

  it '[Site][Banners] switch banner size to 250x250 and verify code /banners.aspx' do
    expect(@non_profit_banners.switch_banner_to_size_works?(:size_250x250)).to be true
  end

  it '[Site][Banners] switch banner size to 468x60 and verify code /banners.aspx' do
    expect(@non_profit_banners.switch_banner_to_size_works?(:size_468x60)).to be true
  end

  it '[Site][Banners] switch banner size to 728x90 and verify code /banners.aspx' do
    expect(@non_profit_banners.switch_banner_to_size_works?(:size_728x90)).to be true
  end

  it '[Site][Banners] switch banner size to 160x600 and verify code /banners.aspx' do
    expect(@non_profit_banners.switch_banner_to_size_works?(:size_160x600)).to be true
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
