# frozen_string_literal: true

require "open3"

module RubyLsp
  module RubyfmtLsp
    class RubyfmtFormatter
      include RubyLsp::Requests::Support::Formatter

      def initialize
        @last_formatting_error = nil
      end

      def run_formatting(_uri, document)
        source = document.source

        stdout_str, stderr_str, status = Open3.capture3("rubyfmt", stdin_data: source)

        unless status.success?
          @last_formatting_error = stderr_str.strip
          return source
        end

        stdout_str
      end

      def run_diagnostic(uri, document)
        return [] unless @last_formatting_error

        [
          RubyLsp::Interface::Diagnostic.new(
            range: RubyLsp::Interface::Range.new(
              start: RubyLsp::Interface::Position.new(line: 0, character: 0),
              end: RubyLsp::Interface::Position.new(line: 0, character: 0)
            ),
            severity: 1,
            message: "rubyfmt error: #{@last_formatting_error}",
            source: "rubyfmt"
          )
        ]
      end
    end
  end
end
