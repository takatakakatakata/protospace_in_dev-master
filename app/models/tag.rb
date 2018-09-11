class Tag < ApplicationRecord
  has_many :prototypes, through: :prototype_tag
end
