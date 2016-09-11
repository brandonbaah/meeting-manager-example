json.array! @tags.each do |tag|
  json.id tag.id
  json.name tag.name
end
