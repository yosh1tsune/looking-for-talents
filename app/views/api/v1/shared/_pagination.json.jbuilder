json.pagination do
  json.current_page      collection.current_page
  json.previous_page     collection.prev_page
  json.next_page         collection.next_page
  json.per_page          collection.limit_value
  json.total_pages       collection.total_pages
  json.total_count       collection.total_count
end
