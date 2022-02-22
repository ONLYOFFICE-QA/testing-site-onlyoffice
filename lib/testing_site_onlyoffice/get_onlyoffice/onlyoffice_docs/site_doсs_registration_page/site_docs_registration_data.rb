# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Default online document data for sign up for cloud
  class DocsRegistrationData
    attr_reader :first_name, :last_name, :doc_email, :doc_phone, :numbers_employees

    def initialize(params = {})
      @first_name = Faker::Name.first_name
      @last_name = Faker::Name.last_name
      @doc_email = SiteData::EMAIL_ADMIN
      @doc_phone = Faker::PhoneNumber.cell_phone_in_e164
      @numbers_employees = params.fetch(:number_employers, 10)
    end

    def generate_incorrect_data
      @first_name = Random.new.rand(1..5)
      @last_name = Random.new.rand(1..5)
      @doc_email = Random.new.rand(1..5)
      @doc_phone = ('a'..'z').to_a.sample
      self
    end
  end
end
