# What

A tool for generating the sprint reports and visualzations I need that
Jira makes difficult to generate. This project will generate visual
and textual representations of key metrics for my project.

## Metrics

1. The types of stories completed in each sprint.
2. The percent of unplanned work completed in the sprint.
3. The percentage of tasks completed (v. rolled) in each sprint, by type.
4. The cycle time of stories, by type.

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
4. *The cycle time of stories, by type.* We expect some types of
   stories to sit in the backlog a long time (big tasks we keep
   shaving bite-sized chunks from, low-priority improvements, etc.),
   but others cannot (e.g., requests from other departments). Given
   our team's purpose, certain tasks need to be worked or marked as
   "won't fix" < ~2 weeks from request time.

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
issue_type,issue_key,unplanned,sprint,completed_in_sprint,days_open,task_area
```

Eventually I'll likely want to generate different reports, and that
will require me pulling more fields into my CSV, but for now I'll keep
it small.

