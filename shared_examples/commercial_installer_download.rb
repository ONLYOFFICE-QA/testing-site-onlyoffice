# frozen_string_literal: true

shared_examples_for 'commercial_installer_download' do |product, installers_list|
  before do
    skip('release/1.62.0 - page has been completely redesigned')
  end

  installers_list[:without_buy_button].each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.get_blocks_by_product(product, installer)
      end

      it "[Site][#{product}] install link for `#{installer}` alive" do
        @current_installation.click_install_button
        marketplace_title = TestingSiteOnlyoffice::SiteDownloadData.commercial_info[product.downcase][installer.to_s]['download']
        expect(installers_download_page.check_opened_page_title).to eq(marketplace_title)
      end
    end
  end

  installers_list[:with_buy_button].each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.get_blocks_by_product(product, installer)
      end

      it "[Site][#{product}] buy link for `#{installer}` alive" do
        pricing_page = @current_installation.click_buy_button
        expect(pricing_page).to be_a(installers_download_page.pricing_page_by_product(product))
      end

      it "[Site][#{product}] install link for `#{installer}` alive" do
        download_form = @current_installation.click_install_button
        expect(download_form.full_name_element).to be_present
      end
    end
  end

  installers_list[:with_instruction].each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.get_blocks_by_product(product, installer)
      end

      it "[Site][#{product}]instruction link for `#{installer}` alive" do
        installers_download_page.click_constructor_link(@current_installation.instruction_xpath)
        instruction_title = TestingSiteOnlyoffice::SiteDownloadData.commercial_info[product.downcase][installer.to_s]['instruction']
        expect(installers_download_page.check_opened_page_title).to eq(instruction_title)
      end
    end
  end

  (installers_list[:with_buy_button] + installers_list[:without_buy_button]).each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.get_blocks_by_product(product, installer)
      end

      it "[Site][#{product}] version and realise date is not empty for `#{installer}`" do
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.release_date_xpath)).not_to be_empty
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.version_xpath)).not_to be_empty
      end
    end
  end
end
