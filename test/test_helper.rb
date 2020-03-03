# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter %r{^/test/}
end

$LOAD_PATH.unshift File.expand_path('../../symbo/lib', __dir__)

require 'active_support'
require 'active_support/test_case'
require 'minitest/autorun'
