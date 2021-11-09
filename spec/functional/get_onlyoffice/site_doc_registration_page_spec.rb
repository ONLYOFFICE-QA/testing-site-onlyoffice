# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
name = Faker::Name.first_name
partner_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)

describe 'Doc registration page' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'Sign Up for cloud' do
    describe 'Create new portal' do
      it 'Create new portal from "Sign Up"' do
        doc_sign_up_page = @site_home_page.click_link_on_toolbar(:onlyoffice_docs_registration)
        doc_sign_up_page.full_params(TestingSiteOnlyoffice::SitePortalCreationData.new.get_instance_hash, name)
        expect(partner_email.check_email_by_subject({ subject: 'Request from: docs-registration' }, 300, true)).to be true
      end
    end
  end
end
