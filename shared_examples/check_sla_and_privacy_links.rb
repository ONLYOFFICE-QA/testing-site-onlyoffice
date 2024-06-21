# frozen_string_literal: true

shared_examples_for 'check_sla_and_privacy_links' do
  it 'Check SLA link works' do
    page.click_sla_link
    expect(page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::SERVICE_LEGAL_AGREEMENT)
  end

  it 'Check Privacy statement link works' do
    page.click_privacy_statement
    expect(page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
  end
end
