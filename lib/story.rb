# frozen_string_literal: true

class Story
  ISSUE_TYPE_FIELD = 'Issue Type'
  ISSUE_KEY_FIELD = 'Issue key'
  LABEL_FIELD = 'Labels'
  SPRINT_FIELD = 'Sprint'
  STATUS_FIELD = 'Status'
  UNPLANNED_FIELD = 'Custom field (Unplanned?)'

  def initialize(row, task_area_regex: /\w+-task-(?<name>\w+)/)
    @row = row
    @task_area_regex = task_area_regex
  end

  def as_sprint_issues
    sprints.map do |sprint|
      {
        issue_type:,
        issue_key:,
        unplanned: unplanned?,
        sprint:,
        completed_in_sprint: completed_in_sprint == sprint,
        task_area:
      }
    end
  end

  def completed_in_sprint
    row[STATUS_FIELD].downcase == 'done' ? sprints.max : nil
  end

  def issue_key
    row[ISSUE_KEY_FIELD]
  end

  def issue_type
    row[ISSUE_TYPE_FIELD]
  end

  def sprints
    @sprints ||= extract_list_field(SPRINT_FIELD)
  end

  # Note that I *assume* that while there might be many labels for a
  # given Story, only one will be the _task_ label for the Story and,
  # furthermore, that label will have the form `project-task-name`,
  # where `name` is the part we want to bubble up for reporting
  # purposes.
  def task_area
    labels.map do |label|
      matches = label.match(task_area_regex)&.named_captures

      matches['name'] if matches
    end.compact.first
  end

  def unplanned?
    row[UNPLANNED_FIELD] ? row[UNPLANNED_FIELD].downcase == 'unplanned work' : false
  end

  def worked?
    !sprints.empty?
  end

  private

  attr_reader :row, :task_area_regex

  def extract_list_field(field_key)
    fields.map { |key, value| value if key == field_key }.compact
  end

  def fields
    @fields ||= row.headers.zip(row.fields)
  end

  def labels
    @labels ||= extract_list_field(LABEL_FIELD)
  end
end
