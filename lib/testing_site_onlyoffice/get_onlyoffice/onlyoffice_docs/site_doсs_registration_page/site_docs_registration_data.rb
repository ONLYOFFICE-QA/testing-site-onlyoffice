# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Default online document data for sign up for cloud
  class DocsRegistrationData
    attr_reader :full_name, :doc_email, :doc_phone

    def initialize(params = {})
      @full_name = Faker::Name.name_with_middle
      @doc_email = SiteData::EMAIL_ADMIN
      @doc_phone = Faker::PhoneNumber.cell_phone_in_e164
    end

    def generate_incorrect_data
      @full_name = Random.new.rand(1..5)
      @doc_email = Random.new.rand(1..5)
      @doc_phone = ('a'..'z').to_a.sample
      self
    end
  end
end
