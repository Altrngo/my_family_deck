class Biberon < Event
  validates :quantity_ml, presence: true, numericality: { greater_than: 0 }

  def quantity_ml
    value_float
  end

  def quantity_ml=(val)
    self.value_float = val
  end
end