json.opportunities @opportunities.map do |opportunity|
  json.id                   opportunity.id
  json.title                opportunity.title
  json.work_description     opportunity.work_description
  json.required_abilities   opportunity.required_abilities
  json.salary               number_to_currency(opportunity.salary)
  json.grade                opportunity.grade
  json.submit_end_date      I18n.l(opportunity.submit_end_date)
  json.status               I18n.t(opportunity.status, scope: [:opportunities])
  json.company              opportunity.company.name
end
