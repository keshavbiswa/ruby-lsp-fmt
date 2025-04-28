# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "ruby_lsp/internal"
require "ruby_lsp/rubyfmt_lsp/addon"
require "ruby_lsp/rubyfmt_lsp/rubyfmt_formatter"

require "minitest/autorun"
