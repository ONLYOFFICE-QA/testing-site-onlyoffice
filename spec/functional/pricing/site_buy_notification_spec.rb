require 'spec_helper'

describe 'Buy Product Notification' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office(config)
    @mail = IredMailHelper.new(username: 'avangate-buy-product@qamail.teamlab.info',
                               password: @test.private_data['mail_avangate-buy-product_pass'])
    @mail.delete_all_messages
  end

  it '[Site][PricingWorkspace] Buy ONLYOFFICE Workspace and check notify /workspace-enterprise-prices.aspx' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_server)
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_enterprise_plus_element, true)
    avangate.submit_avangate_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_WORKSPACE }, 300, true)).to be_truthy
  end

  it '[Site][PricingDocsEnterprise] Buy Docs Enterprise Edition and check notify /docs-enterprise-prices.aspx' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_single_server_element, true)
    avangate.submit_avangate_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_DOCS_ENTERPRISE }, 300,
                                        true)).to be_truthy
  end

  it '[Site][PricingDocsDeveloper] Buy Docs Developer Edition and check notify /developer-edition-prices.aspx' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
    avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_single_server_element, true)
    avangate.submit_avangate_order_for_notification(email: @mail.username)
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
    expect(@mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_DOCS_DEVELOPER }, 300,
                                        true)).to be_truthy
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
