class Tag < ApplicationRecord
  has_many :prototypes, through: :prototype_tag
  has_many :prototype_tag, dependent: :destroy
end
