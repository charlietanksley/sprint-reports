require 'csv'

class Report
  def initialize(filepath)
    @filepath = filepath
  end

  def write_csv(path)
    CSV.open(path, 'w') do |csv|
      csv << %w[issue_type issue_key unplanned sprint completed_in_sprint task_area]
    end
  end

  private

  attr_reader :filepath

  def contents
    @contents ||= CSV.read(filepath, headers: true)
  end
end
