# What

A tool for converting CSV exports from Jira into a format I need for
creating helpful sprint reports and visualizations.

## Metrics

The metrics I intend to generate from this data are:

1. The types of stories completed in each sprint.
2. The percent of unplanned work completed in the sprint.
3. The percentage of tasks completed (v. rolled) in each sprint, by type.
4. The overall percentage of stories completed in each sprint.

## Why these?

1. *The types of stories completed in each sprint.* Since my team
   needs to balance multiple _types_ of work (bug fixes, system tasks,
   requests from customer-facing departments, system upgrades), we
   need to understand if one type of work is taking up all of our
   energy or being neglected.
2. *The percent of unplanned work completed in the sprint.* Our
   sprints are, necessarily, interrupted with urgent tasks. But even
   though this will never go away, we'd like to make this as small a
   portion of our sprint as possible.
3. *The percentage of tasks completed (v. rolled) in each sprint, by
   type.* We know things will roll sometimes. That's fine. But some
   types of tasks can't roll without damaging our credibility with
   outside departments. To keep that trust high, we want to keep an
   eye on which sprint 'commitments' we miss on.
4. *The overall percentage of stories completed in each sprint.*
   Knowing about story completion by type combined with sprint
   composition by story type is a helpful proxy for managing
   relationships with other departments. Overall story completion is a
   helpful way to check on whether the team is overextended and how
   likely we are to deliver a story that is further than one sprint
   out. Not a perfect metric, but still useful.

## Data Shape

The CSV from Jira is a bit messy. It has duplicate column headers for
"Sprint", for example, where those columns are populated from left to
right with each of the sprints the story was in. Here is what those
headers look like:

``` csv
Issue Type,Issue key,Issue id,Summary,Reporter,Status,Resolution,Created,Due date,Custom field (Unplanned?),Sprint,Sprint,Sprint,Labels,Labels,Custom field (Task Needed)
```

And here are the headers I need my CSV to have for the reports I want
to generate:

``` csv
issue_type,issue_key,unplanned,sprint,completed_in_sprint,task_area
```

Eventually I'll likely want to generate different reports, and that
will require me pulling more fields into my CSV, but for now I'll keep
it small.

# Usage

```ruby
require 'report'
report = Report.new('jira-export.csv')
report.write_csv('generated-output.csv')
```

## Ruby types

As of 2022-07-30 I'm experimenting with Ruby 3+ and types. So far, so good? Here's what I did (after I upgraded Ruby):

1. Ran `rbs prototype rb infile.rb > sig/outfile.rbs` for each of my (2) source files to get skeletons.
2. After installing (steep)[https://github.com/soutaro/steep], I ran `steep init`, but I'll be honest I don't understand what to do with the result.
3. I updated as many datatypes as I could using [this reference](https://github.com/ruby/rbs/blob/master/docs/syntax.md) and [this annotation guide](https://github.com/soutaro/steep/blob/master/manual/annotations.md).
4. Ran `steep check` along the way to make sure the types I was adding matched what steep was going to expect.
5. Running `steep stats` is also interesting, but it might be too much info.
6. Running `rbs --log-level=warn test --target Report --target Story rspec` also told me about some expectation mismatches.

Verdict so far: I think this is going to be useful for _some_ things. Specifically, I have a project where I'm writing a series of adapters and I'm worried about them getting out of sync. I believe this would prevent that, which would be massively useful for me.
