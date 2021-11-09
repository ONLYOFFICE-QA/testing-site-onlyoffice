# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Default admin data for creating portal
  class DocsRegistrationData
    attr_accessor :first_name, :last_name, :doc_email, :doc_phone

    def initialize
      @first_name = Faker::Name.first_name
      @last_name = Faker::Name.first_name
      @doc_email = SiteData::EMAIL_ADMIN
      @doc_phone = Faker::PhoneNumber.cell_phone_in_e164
    end
  end
end
