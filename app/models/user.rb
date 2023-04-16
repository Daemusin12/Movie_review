class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  validates :username, presence: true, uniqueness: true
  validates :address_region_id, presence: true
  validates :address_province_id, presence: true
  validates :address_city_id, presence: true
  validates :address_barangay_id, presence: true
  validates :address, presence: true
end
