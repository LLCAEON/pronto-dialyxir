require 'pronto'
require 'pronto/dialyxir/version'
require 'pronto/dialyxir/wrapper'
require 'pronto/dialyxir/output_parser'

module Pronto
  class DialyxirRunner < Runner
    def initialize(_, _)
      super
    end

    def run
      return [] unless @patches

      wrapper = Dialyxir::Wrapper.new

      @patches.select { |p| p.additions > 0 }
          .select { |p| elixir_file?(p.new_file_full_path) }
          .map { |p| inspect(p, wrapper) }
          .flatten
          .compact
    end

    private

    def inspect(patch, wrapper)
      offences = wrapper.lint(patch)
      messages = []

      offences.each do |offence|
        messages += patch
          .added_lines
          .select { |line| line.new_lineno == offence[:line] }
          .map { |line| new_message(offence, line) }
      end

      messages.compact
    end


    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      Message.new(path, line, offence[:level], offence[:message])
    end

    def elixir_file?(path)
      %w(.ex .exs).include?(File.extname(path))
    end
  end
end
