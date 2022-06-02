class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bikes, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :received_bookings, through: :bikes, dependent: :destroy, source: :bookings
  has_one_attached :avatar_picture

  validates :email, :password, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
end
