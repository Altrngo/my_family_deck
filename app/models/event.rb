class Event < ApplicationRecord
  belongs_to :child
  belongs_to :user

  # Liste des types autorisés
  EVENT_TYPES = %w[
    Biberon
    Bobo
    Couche
    Dodo
    Evenement
    Maladie
    Medicament
    Poids
    Repas
    Taille
    Temperature
    Vaccin
  ].freeze

  validates :type, inclusion: { in: EVENT_TYPES }, presence: true
  validates :start_time, presence: true

  # Constants utiles pour les selects
  DIAPER_CONTENT = ["Urine", "Selles", "Mixte", "Sec"].freeze

  scope :chronological, -> { order(start_time: :desc) }
  
 # Optionnel : pour afficher un nom joli dans les vues
  def display_name
    case self.class.name
    when "Biberon" then "Biberon / Allaitement"
    when "Bobo" then "Blessure"
    when "Couche" then "Changement de couche"
    when "Dodo" then "Sommeil"
    else self.class.name
    end
  end
end
