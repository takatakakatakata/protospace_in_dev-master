class Like < ApplicationRecord
  belongs_to :user

  belongs_to :prototype, counter_cache: :likescount

end
