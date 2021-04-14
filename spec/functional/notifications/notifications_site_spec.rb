require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

site_helper = TestingSiteOnlyoffice::SiteHelper.new

mail_site = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
partner_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
client_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)

describe 'Registration new portal' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  it 'Check button `Recover` work on `wrong portal name` page for correct email' do
    wrong_page = site_helper.wrong_portal_name
    wrong_page.recover_address_portal(TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
    expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(language: config.language,
                                                                                 module: 'WebStudio',
                                                                                 mail: mail_site,
                                                                                 pattern: 'portal_name_reminder',
                                                                                 search: TestingSiteOnlyoffice::SiteData.site_notification_page)).to be_truthy
  end

  # CAUTION: do not test on .com frequently
  describe 'Partnership' do
    it '[Site][Partnership] Send request for partnership' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      partnership_request_page = @site_home_page.click_link_on_toolbar(:submit_request)
      company_name = "nctautotest #{Time.now} For Developers /partnership-request.aspx?requestType=1"
      partnership_request_page.send_partners_form_random_data(company_name: company_name)
      subject_message = "#{company_name} - Partner Request"
      expect(partnership_request_page.partner_request_successful_element).to be_present
      expect(partner_email.check_email_by_subject({ subject: subject_message }, 300, true)).to be true
    end
  end

  describe 'Order Demo' do
    it '[Site][OrderDemo] Send demo-order request /demo-order.aspx' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      demo_order_page = @site_home_page.click_order_demo
      company_name = "nctautotest #{Time.now} /demo-order.aspx"
      demo_order_page.send_demonstration_request(company_name: company_name)
      expect(demo_order_page).to be_a TestingSiteOnlyoffice::SiteOrderDemo
      expect(partner_email.check_email_by_subject(
               { subject: TestingSiteOnlyoffice::SiteNotificationData::ORDER_DEMO_REQUEST, search: company_name }, 300, true
             )).to be true
    end
  end

  describe 'Call back' do
    it '[Site][CallBack] Check request a call /call-back-form.aspx' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      site_callback_page = @site_home_page.click_request_a_call
      last_name = "nctautotest #{Time.now} /call-back-form.aspx"
      site_callback_page.send_callback_request(last_name: last_name)
      expect(site_callback_page).to be_congratulation_visible
      expect(partner_email.check_email_by_subject(
               { subject: TestingSiteOnlyoffice::SiteNotificationData::CALL_BACK_REQUEST, search: last_name }, 300, true
             )).to be true
    end
  end

  describe 'Subscribe' do
    it 'Subscribe to news' do
      subscribe_popup = @site_home_page.click_subscribe_to_newsletter
      subscribe_popup.fill_subscribe_form
      mail_html = client_email.get_html_body_email_by_subject(
        { subject: TestingSiteOnlyoffice::SiteNotificationData::SUBSCRIBE_TO_NEWSLETTER }, 300
      )
      subscribe_link = TestingSiteOnlyoffice::SiteSubscribe.parse_subscribe_link(mail_html)
      subscribe_confirm = subscribe_popup.subscribe_from_link(subscribe_link)
      expect(subscribe_confirm).to be_wait_success_text_visible
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test&.webdriver&.quit
    site_helper.test&.webdriver&.quit
  end
end
