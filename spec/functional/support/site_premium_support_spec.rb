# frozen_string_literal: true

require 'spec_helper'

describe 'Buy Product Notification' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @mail = IredMailHelper.new(username: 'avangate-buy-product@qamail.teamlab.info',
                               password: @test.private_data['mail_avangate-buy-product_pass'])
    @premium_support_page = site_home_page.click_premium_support
    @mail.delete_all_messages
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][PremiumSupport] Buy Premium Support Plus and check notify /support.aspx' do
    pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
    avangate = @premium_support_page.go_to_avangate_from_pricing_page(@premium_support_page.buy_now_support_element, test_purchase: true)
    avangate.submit_avangate_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
  end

  it '[Site][PremiumSupport] `Choose your plan` button works for Basic plan' do
    expect(@premium_support_page.choose_your_plan).to be_a TestingSiteOnlyoffice::SitePriceDocsEnterprise
  end

  it '[Site][PremiumSupport] Prices on store.onlyoffice.com and onlyoffice.com are the same for 100 users for `Plus` plan' do
    @premium_support_page.increase_plus_users
    plus_price_data = @premium_support_page.current_support_plus_price_and_user_number
    expect(plus_price_data[:user_number]).to eq(100)
    avangate = @premium_support_page.go_to_avangate_from_pricing_page(@premium_support_page.buy_now_support_element, test_purchase: true)
    avangate_price = avangate.get_avangate_current_price_value.to_i
    expect(avangate_price).to eq(plus_price_data[:price])
  end

  it '[Pricing][PremiumSupport] `Get a quote` button for more then 200 users contains link to email for for `Plus` plan' do
    3.times { @premium_support_page.increase_plus_users }
    expect(@premium_support_page.plus_get_a_quote_element).to be_present
    expect(@premium_support_page.plus_quote_email).to start_with('mailto:sales@onlyoffice.com')
  end

  it '[Pricing][PremiumSupport] `Get a quote` button for more then 200 users contains link to email for for `Premium` plan' do
    3.times { @premium_support_page.increase_premium_users }
    expect(@premium_support_page.premium_get_a_quote_element).to be_present
    expect(@premium_support_page.premium_quote_email).to start_with('mailto:sales@onlyoffice.com')
  end

  it '[Pricing][PremiumSupport] `+` and `-` buttons work for `Plus` plan' do
    @premium_support_page.increase_plus_users
    plus_price_data = @premium_support_page.current_support_plus_price_and_user_number
    expect(plus_price_data[:user_number]).to eq(100)
    expect(plus_price_data[:price]).to eq(TestingSiteOnlyoffice::SitePricesData.plus_support_100)
    @premium_support_page.decrease_plus_users
    plus_price_data = @premium_support_page.current_support_plus_price_and_user_number
    expect(plus_price_data[:user_number]).to eq(50)
    expect(plus_price_data[:price]).to eq(TestingSiteOnlyoffice::SitePricesData.plus_support_50)
  end

  it '[Pricing][PremiumSupport] `+` and `-` buttons work for `Premium` plan' do
    @premium_support_page.increase_premium_users
    premium_price_data = @premium_support_page.current_support_premium_price_and_user_number
    expect(premium_price_data[:user_number]).to eq(100)
    expect(premium_price_data[:price]).to eq(TestingSiteOnlyoffice::SitePricesData.premium_support_100)
    @premium_support_page.decrease_premium_users
    premium_price_data = @premium_support_page.current_support_premium_price_and_user_number
    expect(premium_price_data[:user_number]).to eq(50)
    expect(premium_price_data[:price]).to eq(TestingSiteOnlyoffice::SitePricesData.premium_support_50)
  end
end
