# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Default admin data for creating portal
  class SitePortalCreationData
    attr_accessor :first_name, :last_name, :email, :password, :portal_name, :users_number, :language

    def initialize(params = {})
      file_name = params.fetch(:file_name, $ARGV[0])
      @first_name = SiteData::DEFAULT_ADMIN_NAME
      @last_name = SiteData::DEFAULT_ADMIN_LASTNAME
      @email = SiteData::EMAIL_ADMIN
      @password ||= SiteData::PORTAL_PASSWORD
      @portal_name = "nctautotest-#{portal_name_timestamp}-#{file_name.split('/').last.split('.rb')[0].downcase.tr('_', '-')}"[0...50]
      @users_number = '1-3'
      @language = 'English'
    end

    def get_instance_hash
      {
        first_name: @first_name,
        last_name: @last_name,
        email: @email,
        password: @password,
        portal_name: @portal_name,
        users_number: @users_number,
        language: @language
      }
    end

    private

    # @return [String] timestamp used in portal name
    def portal_name_timestamp
      Time.now.strftime('%Y%m%d%H%M%S')
    end
  end
end
