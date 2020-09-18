require 'csv'
require 'story'

class Report
  def initialize(filepath)
    @filepath = filepath
  end

  def write_csv(path)
    CSV.open(path, 'w') do |csv|
      csv << %w[issue_type issue_key unplanned sprint completed_in_sprint task_area]
      sprint_issues.each do |row|
        csv << row
      end
    end
  end

  def sprint_issues
    contents.map { |issue| Story.new(issue) }
            .select(&:worked?)
            .flat_map(&:as_sprint_issues)
  end

  private

  attr_reader :filepath

  def contents
    @contents ||= CSV.read(filepath, headers: true)
  end
end
