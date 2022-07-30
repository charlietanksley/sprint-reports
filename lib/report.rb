# frozen_string_literal: true

require 'csv'
require 'story'

class Report
  def initialize(filepath, **story_config)
    @filepath = filepath
    @story_config = story_config
  end

  def write_csv(path)
    CSV.open(path, 'w') do |csv|
      csv << %w[issue_type issue_key unplanned sprint completed_in_sprint task_area]
      sprint_issues.each do |sprint_issue|
        csv << sprint_issue.values
      end
    end
  end

  def sprint_issues
    contents.map { |issue| Story.new(issue, **story_config) }
            .select(&:worked?)
            .flat_map(&:as_sprint_issues)
  end

  private

  attr_reader :filepath, :story_config

  def contents
    # @type ivar @contents: CSV::Table
    @contents ||= CSV.read(filepath, headers: true)
  end
end
