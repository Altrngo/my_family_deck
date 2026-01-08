class Poids < Event
  validates :weight_kg, presence: true, numericality: { greater_than: 0 }

  def weight_kg
    value_float
  end

  def weight_kg=(val)
    self.value_float = val
  end
end