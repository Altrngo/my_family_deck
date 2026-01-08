class Temperature < Event
  validates :temperature_celsius, presence: true, numericality: true

  def temperature_celsius
    value_float
  end

  def temperature_celsius=(val)
    self.value_float = val
  end
end