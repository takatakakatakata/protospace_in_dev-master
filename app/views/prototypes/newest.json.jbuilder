json.prototypes @prototypes do |prototype|
  json.image        prototype.set_main_thumbnail
  json.title        prototype.title
  json.user_name    prototype.user.name
  json.id           prototype.id
  json.posted_date  prototype.posted_date
  json.user_id      prototype.user.id
end
