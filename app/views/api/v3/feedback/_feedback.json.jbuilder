json.id feedback.uuid
json.createdAt feedback.generated_at
json.isNew feedback.recent?
json.token feedback.token
json.employeeId feedback.employee.uuid
json.employeeName feedback.employee.name
json.teamId feedback.team.uuid
json.result result_to_text(feedback.result)
json.message feedback.description
if feedback.replies.any?
  json.replyEmployeeId feedback.replies.first.employee.uuid
  json.replyEmployeeName feedback.replies.first.employee.name
  json.replyMessasge feedback.replies.first.description
  json.replyCreatedAt feedback.replies.first.created_at
end
