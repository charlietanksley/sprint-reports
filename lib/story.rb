class Story
  ISSUE_TYPE_FIELD = 'Issue Type'.freeze
  ISSUE_KEY_FIELD = 'Issue key'.freeze
  LABEL_FIELD = 'Labels'.freeze
  SPRINT_FIELD = 'Sprint'.freeze
  STATUS_FIELD = 'Status'.freeze
  UNPLANNED_FIELD = 'Custom field (Unplanned?)'.freeze

  def initialize(row)
    @row = row
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
    labels.select { |label| /\w+-task-\w+/.match(label) }
          .first
          .split('-')
          .last
  end

  def unplanned?
    row[UNPLANNED_FIELD].downcase == 'unplanned work'
  end

  def worked?
    !sprints.empty?
  end

  private

  attr_reader :row

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
