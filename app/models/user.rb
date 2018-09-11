class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, UserImageUploader

  has_many :prototypes

    # いいね機能のアソシエーション
  has_many :likes, dependent: :destroy
  has_many :like_prototypes, through: :likes, source: :prototypes

  validates :name, presence: true
end
