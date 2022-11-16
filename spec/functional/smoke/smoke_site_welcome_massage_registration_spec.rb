# frozen_string_literal: true

require 'spec_helper'
require 'timeout'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN)

checker = { mail:, module: 'WebStudio', move_out: true }

describe 'Site Smoke welcome massage' do
  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
    describe "Registration #{current_language}" do
      let(:portal_creation_data) { TestingSiteOnlyoffice::SitePortalCreationData.new.get_instance_hash }
      let(:portal_url) { TestingSiteOnlyoffice::PortalHelper.new.get_full_portal_name(portal_creation_data[:portal_name]) }

      it "Check welcome message for #{current_language}" do
        TestingSiteOnlyoffice::SiteHelper.new.create_portal_change_language_site(portal_creation_data, current_language)
        confirmation_link = TestingSiteOnlyoffice::SiteNotificationHelper.confirmation_registration_link(checker.merge(language: current_language,
                                                                                                                       pattern: 'subject_confirmation',
                                                                                                                       search: portal_url))
        @sign_in_page = TestingSiteOnlyoffice::SiteHelper.new.registration_confirmation(confirmation_link, portal_creation_data)
        expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(language: current_language,
                                                                                                   pattern: 'subject_congratulations',
                                                                                                   search: portal_url))).to be_truthy
      end
    end
  end
end
