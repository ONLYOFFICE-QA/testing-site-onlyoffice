# frozen_string_literal: true

require_relative '../modules/site_toolbar'
require_relative 'modules/site_pricing_helper'

module TestingSiteOnlyoffice
  # Pricing for Onlyoffice Docs Developer edition
  # https://user-images.githubusercontent.com/40513035/100148241-89bcbe00-2ead-11eb-8683-52e8eb21a710.png
  class SitePriceDocsDeveloper
    include PageObject
    include SitePricingHelper
    include SiteToolbar

    link(:buy_now_single_server, xpath: "//a[contains(@class, 'saas-price-url')]")
    span(:single_server_price, xpath: "//span[@class='saas-price']")
    element(:single_server_connections_num, xpath: "//div[@class='saas server_price_recommendation spr_block2']/p/b")
    div(:single_server_connections_num_increase, xpath: "//div[@class='saas simcon_change connections_increase']")
    div(:single_server_connections_num_decrease, xpath: "//div[@class='saas simcon_change connections_decrease']")

    development_server_block = "(//div[@class='price-block'])[1]"
    link(:buy_now_development_server, xpath: "#{development_server_block}//a[@class='button gray']")
    div(:development_server_price, xpath: development_server_block)
    element(:development_server_connections_num,
            xpath: "(//div[@class='server_price_recommendation spr_block1']/p/b)[1]")

    link(:get_a_quote, xpath: "//a[contains(@class, 'on-premise-price-url')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        buy_now_single_server_element.present?
      end
    end

    def current_single_server_price
      @instance.webdriver.wait_until do
        single_server_price_element.present? && single_server_connections_num_element.present?
      end
      price = single_server_price_element.text.to_i
      connections_num = single_server_connections_num_element.text.to_i
      [price, connections_num]
    end

    def increase_single_server_connections_num
      single_server_connections_num_increase_element.click
    end

    def decrease_single_server_connections_num
      single_server_connections_num_decrease_element.click
    end

    def click_buy_now_single_server
      buy_now_single_server_element.click
      Avangate.new(@instance)
    end

    def current_development_server_price
      @instance.webdriver.wait_until do
        development_server_price_element.present? && development_server_connections_num_element.present?
      end
      price = development_server_price_element.text.scan(/\d+/)[0].to_i
      connections_num = development_server_connections_num_element.text.to_i
      [price, connections_num]
    end

    def click_buy_now_development_server
      buy_now_development_server_element.click
      Avangate.new(@instance)
    end

    def cluster_quote_email
      @instance.webdriver.get_attribute(get_a_quote_element, 'href')
    end
  end
end
