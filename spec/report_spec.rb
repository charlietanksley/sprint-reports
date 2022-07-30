# frozen_string_literal: true

$LOAD_PATH.unshift('lib')

require 'pry-byebug'

require 'report'

RSpec.describe Report do
  let(:input_file) { 'spec/data/jira_export.csv' }

  describe 'generating a csv for creating visualizations' do
    let(:expected_output) { 'spec/data/output.csv' }
    let(:report) { described_class.new(input_file) }

    it 'writes a csv in the format we need for generating visualizations' do
      outfile = Tempfile.new
      report.write_csv(outfile)
      expect(outfile.read).to eq(File.read(expected_output))
    end
  end

  describe 'configuring fields' do
    let(:report) do
      described_class.new(input_file,
                          task_area_regex: /\w+-label-(?<name>\w+)/)
    end

    it 'applies configurations to the stories in the sprints' do
      task_areas = report.sprint_issues.map { |row| row[:task_area] }
      expect(task_areas).to match_array(['1', '1', '1', nil, '2', '2'])
    end
  end
end
