# frozen_string_literal: true

require 'spec_helper'

describe 'Buy Product Notification' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @mail = IredMailHelper.new(username: 'avangate-buy-product@qamail.teamlab.info',
                               password: @test.private_data['mail_avangate-buy-product_pass'])
    @mail.delete_all_messages
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][PricingWorkspace] Buy ONLYOFFICE Workspace and check notify /workspace-enterprise-prices.aspx' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_server)
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_enterprise_plus_element, test_purchase: true)
    avangate.submit_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_WORKSPACE, include_read: true }, 300, true)).to be_truthy
  end

  it '[Site][PricingDocsEnterprise] Buy Docs Enterprise Edition and check notify /docs-enterprise-prices.aspx' do
    skip('Stripe payments cannot be checked on production') if config.server.include?('.com')
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    pricing_page.choose_support_basic
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_single_server_element, test_purchase: true)
    avangate.submit_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_DOCS_ENTERPRISE, include_read: true }, 300,
                                        true)).to be_truthy
  end

  it '[Site][PricingDocsEnterprise] Buy Docs Enterprise Edition for home and check notify /docs-enterprise-prices.aspx' do
    skip('Stripe payments cannot be checked on production') if config.server.include?('.com')
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    pricing_page.choose_home_tariff
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_home_server_element, test_purchase: true)
    avangate.submit_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_DOCS_ENTERPRISE, include_read: true }, 300,
                                        true)).to be_truthy
  end

  it '[Site][PricingDocsDeveloper] Buy Docs Developer Edition and check notify /developer-edition-prices.aspx' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_single_server_element, test_purchase: true)
    avangate.submit_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_DOCS_DEVELOPER, include_read: true }, 300,
                                        true)).to be_truthy
  end
end
