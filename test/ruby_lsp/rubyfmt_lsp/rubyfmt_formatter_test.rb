# frozen_string_literal: true

require "test_helper"

class RubyfmtFormatterTest < Minitest::Test
  def setup
    @formatter = RubyLsp::RubyfmtLsp::RubyfmtFormatter.new
    @document_data = Data.define(:source)
  end

  def test_successful_formatting
    document = @document_data.new(source: "puts  1+2")

    formatted = @formatter.run_formatting(URI("file:///test.rb"), document)

    refute_equal("puts  1+2", formatted)
    assert_includes(formatted, "puts(1 + 2)")
    assert_empty(@formatter.run_diagnostic(URI("file:///test.rb"), document))
  end

  def test_formatting_failure_returns_diagnostic
    document = @document_data.new(source: "def invalid(")

    formatted = @formatter.run_formatting(URI("file:///test.rb"), document)

    assert_equal("def invalid(", formatted)
    diagnostics = @formatter.run_diagnostic(URI("file:///test.rb"), document)

    refute_empty(diagnostics)
    puts diagnostics.first.message

    assert_match("rubyfmt error: Error! source: stdin", diagnostics.first.message)
  end

  def test_missing_rubyfmt_binary_returns_diagnostic
    document = @document_data.new("puts 1+2")

    Open3.stub(:capture3, ->(*args) { raise Errno::ENOENT }) do
      formatted = @formatter.run_formatting(URI("file:///test.rb"), document)

      assert_equal("puts 1+2", formatted)

      diagnostics = @formatter.run_diagnostic(URI("file:///test.rb"), document)

      refute_empty(diagnostics)
      assert_match("rubyfmt not found", diagnostics.first.message)
    end
  end
end
