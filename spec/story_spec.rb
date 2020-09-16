$LOAD_PATH.unshift('lib')

require 'csv'
require 'pry-byebug'

require 'story.rb'

RSpec.describe Story do
  let(:headers) do
    ['Issue Type',
     'Issue key',
     'Issue id',
     'Summary',
     'Status',
     'Resolution',
     'Created',
     'Custom field (Unplanned?)',
     'Sprint',
     'Sprint',
     'Sprint',
     'Labels',
     'Labels']
  end
  let(:fields) do
    ['Task',
     'PROJ-1',
     '1',
     'First issue',
     'Done',
     'Done',
     '19/Aug/20 12:36 PM',
     'Unplanned Work',
     'PROJ Sprint 1',
     'PROJ Sprint 2',
     'PROJ Sprint 3',
     'proj-task-a',
     'proj-label-1']
  end
  let(:row) { CSV::Row.new(headers, fields) }

  subject { described_class.new(row) }

  it "knows it's issue_type" do
    expect(subject.issue_type).to eq('Task')
  end

  it "knows it's issue_key" do
    expect(subject.issue_key).to eq('PROJ-1')
  end

  it 'knows whether it was unplanned' do
    expect(subject.unplanned?).to eq(true)
  end

  it 'knows what sprints it was in' do
    expect(subject.sprints).to match_array(['PROJ Sprint 1', 'PROJ Sprint 2', 'PROJ Sprint 3'])
  end

  it 'knows which sprint it was completed in' do
    expect(subject.completed_in_sprint).to eq('PROJ Sprint 3')
  end

  it 'knows what task area it is in' do
    expect(subject.task_area).to eq('a')
  end
end
