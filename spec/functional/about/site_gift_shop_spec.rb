# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Gift shop' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @gift_shop = site_home_page.click_link_on_toolbar(:about_gift_shop)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Gift shop] Go to Gift shop' do
    expect(@gift_shop).to be_a TestingSiteOnlyoffice::SiteAboutGiftShop
  end

  it '[Gift shop] Go to shop now' do
    expect(@gift_shop.go_to_shop_now).to be(true)
  end
end
