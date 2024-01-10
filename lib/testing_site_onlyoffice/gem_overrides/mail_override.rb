# frozen_string_literal: true

module OnlyofficeIredmailHelper
  # Additional method to work with IredMailHelper class
  class IredMailHelper
    def check_pricing_docspace_mail_by_body(params = {})
      email_body = get_text_body_email_by_subject(params)
      number = parse_phone_number(email_body)
      email_body.sub!(number, number.delete(' '))
      body = split_email_body(email_body)
      basic_email_content_check(body, params) && multi_server_deployment?(params[:support_multi], body) && training_courses?(params[:training_course], body)
    end

    def check_pricing_enterprise_mail_by_body(params = {})
      email_body = get_text_body_email_by_subject(params)
      number = parse_phone_number(email_body)
      email_body.sub!(number, number.delete(' '))
      body = split_email_body(email_body)
      basic_email_content_check(body, params) &&
        recovery_support?(params[:support_recovery], body) &&
        multi_server_deployment?(params[:support_multi], body) &&
        training_courses?(params[:training_course], body) &&
        license_activated?(params[:duration], body)
    end

    # Split email body string into an array of strings without "space" character
    # @param [String] body - email content string
    # @return [Array] split values of an email body
    def split_email_body(body)
      body.split(/[\s\:]/)
    end

    # Check whether full name from parameters is equal to the name from an email.
    # Find an index of the word that comes before the name and take the next word as name.
    # E.g. 'Full', 'name', 'Andrew', 'Johnson' -> 'name' is the key word here so the next word is the actual name -> 'Andrew'
    # @param [String] full_name name to be matched
    # @param [Array] body array of parsed values
    # @return [Boolean] True if matches, False if not
    def full_name_match?(full_name, body)
      full_name == "#{body[body.find_index('name') + 1]} #{body[body.find_index('name') + 2]}"
    end

    def email_match?(email, body)
      email == body[body.find_index('Email') + 1]
    end

    def phone_number_match?(phone_number, body)
      phone_number == body[body.find_index('Phone') + 1]
    end

    def company_name_match?(company_name, body)
      company_name == body[(body.find_index('Name') + 1)..(body.find_index('Language') - 1)].join(' ')
    end

    def support_level_match?(support_level, body)
      support_level == body[body.find_index('level') + 1]
    end

    def users_number_match?(users_number, body)
      users_number == body[body.find_index('Number') + 3]
    end

    # Method that checks the commonly shared inputs between different emails
    # @param [Array] body array of parsed values
    # @param [Hash] params inputs of the email
    # @return [Boolean] True if all 4 methods return true, False if at least 1 method returns false
    def basic_email_content_check(body, params = {})
      full_name_match?(params.fetch(:full_name, TestingSiteOnlyoffice::SiteData::DEFAULT_ADMIN_FULLNAME), body) &&
        email_match?(params.fetch(:email, TestingSiteOnlyoffice::SiteData::EMAIL_ADMIN), body) &&
        phone_number_match?(params[:phone_number], body) &&
        company_name_match?(params[:company_name], body) &&
        support_level_match?(params[:level], body) &&
        users_number_match?(params[:users_number], body)
    end

    def multi_server_deployment?(status, body)
      support = body[body.find_index('deployment') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def training_courses?(status, body)
      support = body[body.find_index('courses') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def recovery_support?(status, body)
      support = body[body.find_index('recovery') + 1]
      support == if status
                   'Selected'
                 else
                   'Not'
                 end
    end

    def license_activated?(duration, body)
      license = body[body.find_index('duration') + 1]
      support = body[body.find_index('Support&Updates') + 1]
      if duration == 'one_year'
        (license == '1') && (support == '1')
      elsif duration == 'lifetime'
        (license == 'Lifetime') && (support == '3')
      end
    end

    # Get the value of a phone number from the email body.
    # It is standard regex to match cell phone numbers in format E.164 (e.g. +1 896 4562767, +44 20 567483456)
    def parse_phone_number(email_body)
      email_body.scan(/[+][0-9]*\s?[0-9]+\s?[0-9]{4,10}/).join
    end
  end
end
