# frozen_string_literal: true

require "ruby_lsp/addon"

module RubyLsp
  module RubyfmtLsp
    class Addon < RubyLsp::Addon
      def name
        "Ruby LSP Rubyfmt Formatter"
      end

      def activate(global_state, _message_queue)
        global_state.register_formatter("rubyfmt-lsp", RubyfmtFormatter.new)
      end

      def deactivate
      end

      def version
        "0.1.0"
      end
    end
  end
end
