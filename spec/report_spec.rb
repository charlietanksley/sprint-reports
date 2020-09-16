$LOAD_PATH.unshift('lib')

require 'pry-byebug'

require 'report.rb'

RSpec.describe Report do
  let(:input_file) { 'spec/data/jira_export.csv' }

  describe 'generating a csv for creating visualizations' do
    let(:expected_output) { 'spec/data/output.csv' }
    let(:report) { described_class.new(input_file) }

    xit 'writes a csv in the format we need for generating visualizations' do
      outfile = Tempfile.new
      report.write_csv(outfile)
      expect(outfile.read).to eq(File.read(expected_output))
    end
  end
end
