class Tag < ApplicationRecord
  has_many :prototype_tag, dependent: :destroy
  has_many :prototypes, through: :prototype_tag
end
