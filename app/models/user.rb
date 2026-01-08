class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Relations
  has_many :child_accesses, dependent: :destroy
  has_many :children, through: :child_accesses
  has_many :events, dependent: :destroy
  # Enfants dont je suis le propriétaire principal
  has_many :owned_children, class_name: "Child", foreign_key: "owner_id", dependent: :destroy
end
