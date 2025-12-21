class ChildAccess < ApplicationRecord
  belongs_to :child
  belongs_to :user

  enum :role, {
    parent: "parent",   # droits complets,peut inviter/supprimer des accés
    family: "family",   # peut ajouter modifier des évenements
    caregiver: "garde", # peut ajouter modifier des évènements
    medic: "médical",   # peut ajouter modifier des évènements
    viewer: "viewer",   #lecture seule
  }, default: :viewer

  validates :user_id, uniqueness: { scope: :child_id } # déjà protégé par l'index unique
end
