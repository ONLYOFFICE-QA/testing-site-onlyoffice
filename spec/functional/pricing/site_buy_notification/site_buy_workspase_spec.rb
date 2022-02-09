# frozen_string_literal: true

require 'spec_helper'

describe 'Buy Product Workspase Notification' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  site_home_page, test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  mail = IredMailHelper.new(username: 'avangate-buy-product@qamail.teamlab.info', password: test.private_data['mail_avangate-buy-product_pass'])
  mail.delete_all_messages

  pricing_page = site_home_page.click_link_on_toolbar(:pricing_server)
  avangate = pricing_page.go_to_avangate_from_pricing_page(pricing_page.buy_now_enterprise_plus_element, test_purchase: true)
  avangate.submit_avangate_order_for_notification(email: mail.username)

  after do |example|
    test_manager.add_result(example, test)
    test.webdriver.quit
  end

  it '[Site][PricingWorkspace] Check notify purchase /workspace-enterprise-prices.aspx' do
    expect(mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PURCHASE_WORKSPACE, include_read: true }, 300,
                                       true)).to be_truthy
  end

  it '[Site][PricingWorkspace] Check notify avangate /workspace-enterprise-prices.aspx' do
    pending('Waiting more than 5 minutes for a letter')
    expect(mail.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::PAYMENT_RECEIVED }, 300, true)).to be_truthy
  end
end
