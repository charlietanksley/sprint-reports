require 'csv'
require 'story'

class Report
  def initialize(filepath)
    @filepath = filepath
  end

  def write_csv(path)
    CSV.open(path, 'w') do |csv|
      csv << %w[issue_type issue_key unplanned sprint completed_in_sprint task_area]
      contents.map { |issue| Story.new(issue) }
              .select(&:worked?)
              .flat_map(&:as_sprint_issues)
              .each { |row| csv << row }
    end
  end

  private

  attr_reader :filepath

  def contents
    @contents ||= CSV.read(filepath, headers: true)
  end
end
