require 'open3'
require_relative 'output_parser'

module Pronto
  module Dialyxir
    class Wrapper
      attr_reader :patch

      def initialize(patch)
        @patch = patch
      end

      def lint
        return [] if patch.nil?
        path = patch.delta.new_file[:path]
        stdout, stderr, _ = Open3.capture3(dialyxir_executable)
        puts "WARN: pronto-dialyxir: #{stderr}" if stderr && stderr.size > 0
        return {} if stdout.nil? || stdout == 0
        OutputParser.new(path, stdout).parse
      end

      private

      def dialyxir_executable
        "mix dialyzer --format short --no-check --quiet"
      end
    end
  end
end
