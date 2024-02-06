# frozen_string_literal: true

require_relative 'mail_helper'
require 'onlyoffice_iredmail_helper'

module OnlyofficeIredmailHelper

  # Class that holds email body which is parsed into array of strings
  class MailParseBody < IredMailHelper
    include MailHelper

    def initialize(params)
      super(username: params[:username])
      @params = params
      @body = parse_email_body(params)
    end

    # Method that parses email body and returns it in array
    # 1. Get the email body in a single string
    # 2. Get the phone number from the string and replace it without any 'space' characters to match the E.164 format
    # 3. Split the email body into array of strings
    # @return [Array] array of strings
    def parse_email_body(params)
      email_body = get_text_body_email_by_subject(params)
      number = parse_phone_number(email_body)
      email_body.sub!(number, number.delete(' '))
      split_email_body(email_body)
    end

    # Split email body string into an array of strings without "space" character
    # @param [String] body - email content string
    # @return [Array] split values of an email body
    def split_email_body(body)
      body.split(/[\s\:]/)
    end

    # Get the value of a phone number from the email body.
    # It is standard regex to match cell phone numbers in format E.164 (e.g. +1 896 4562767, +44 20 567483456)
    def parse_phone_number(email_body)
      email_body.scan(/[+][0-9]*\s?[0-9]+\s?[0-9]{4,10}/).join
    end
  end
end
