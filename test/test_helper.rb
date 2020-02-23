# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
SimpleCov.start do
  add_filter %r{^/test/}
end

require 'active_support'
require 'active_support/test_case'
require 'minitest/autorun'
