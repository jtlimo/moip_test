require 'rspec/expectations'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'capybara/window'
require 'selenium-webdriver'
require 'site_prism'
require 'pry'
require 'data_magic'
require 'base64'
World(RSpec::Matchers)

env = %w(sandbox).include?(ENV['ENV']) ? ENV['ENV'].to_sym : :sandbox

Dir['../.././pages/*.rb'].each { |file| require file }

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

AMBIENTES_CONFIG = {
  sandbox: ['sandbox.moip.com.br']
}.freeze

CONTA_MOIP_CONFIG = {
  sandbox: ['connect-sandbox.moip.com.br']
}.freeze

CONFIG = {
  sandbox:  %w(OKIE1XNH5DDXF7S3IPFPZKHJK8CIVJNF
               5HS6OZKDXDABBMZGTY5PABV05F9CPVGCWOU7OYW2)
}.freeze

CONFIG_AUTH = {
  sandbox:  %w(user password)
}.freeze

MOIP_URL = AMBIENTES_CONFIG.fetch(env)[0]
CONTA_MOIP_URL = CONTA_MOIP_CONFIG.fetch(env)[0]
USERNAME = CONFIG_AUTH.fetch(env)[0]
PASSWORD = CONFIG_AUTH.fetch(env)[1]
TOKEN = CONFIG.fetch(env)[0]
KEY = CONFIG.fetch(env)[1]
