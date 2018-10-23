module Pronto
  module Dialyxir
    class OutputParser
      attr_reader :output, :file

      def initialize(file, output)
        @file = file
        @output = output
      end

      def parse
        return {} if output.to_s.empty?

        if output.lines[2].start_with?("== Compilation error")
          return [{
                    line: 0,
                    column: nil,
                    level: :error,
                    message: output.chomp("\n")
                  }]
        end

        output.lines.map do |line|
          line_parts = line.split(':')
          type, message = line_parts[2..-1].join(":").split(' ', 2)
          next unless file.start_with?(line_parts[0])
          {
            line: line_parts[1].to_i,
            column: nil,
            level: :warning,
            message: message.chomp("\n")
          }
        end.compact
      end
    end
  end
end
