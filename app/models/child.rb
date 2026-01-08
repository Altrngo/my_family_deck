class Child < ApplicationRecord
  #Relations
  has_many :child_accesses, dependent: :destroy
  has_many :users, through: :child_accesses
  has_many :events, dependent: :destroy

  #Propriétaire principal, celui qui créél'enfant
  belongs_to :owner, class_name: "User" #optional: true


  #validations
  validates :name, presence: true
    validates :birth_date, presence: true
end
