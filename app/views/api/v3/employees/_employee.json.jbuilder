json.id employee.uuid
json.name employee.name
json.email employee.email
json.avatar employee_avatar_link(employee)
json.teamId employee.team.uuid
json.teamName employee.team.name

if @is_manager
  json.hms employee.hms
  json.involvement employee.involvement
  json.points employee.points
  json.levelName employee.level_name
  json.worseThanExpected employee.results_bad
  json.betterThanExpected employee.results_good
  json.asExpected employee.results_fine
  json.high5Received employee.high5_received
  json.high5Given employee.high5_given
  json.numberComments employee.comments
  json.totalVotes employee.feedback_given
  json.status (employee.deleted? ? 'Archived' : 'Active')
  json.teamId employee.team.uuid
  json.teamName employee.team.name
  json.pushKey employee.push_key
end
