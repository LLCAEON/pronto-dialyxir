require 'spec_helper'
require 'pathname'
require 'pronto/dialyxir/output_parser'

RSpec.describe Pronto::Dialyxir::OutputParser do
  let(:parser) { described_class.new(file, output) }
  let(:file) { 'lib/my_app/db.ex' }
  let(:output) { File.read("#{Pathname.pwd}/spec/fixtures/dialyxir_output.txt") }

  describe '#parse' do
    subject { parser.parse }
    it 'parses output' do
      expect(subject).to eq(
        [
          { line: 12,
            :column => nil,
            :level => :warning,
            :message=>"Function get/1 has no local return."
          },
          { line: 66,
            :column => nil,
            :level => :warning,
            :message => "The function call will fail."
          },
          { line: 93,
            :column => nil,
            :level => :warning,
            :message => "Call to missing or private function MyApp.Db.subscribe/1."
          }
        ]
      )
    end
  end
end
