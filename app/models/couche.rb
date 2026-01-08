class Couche < Event
  DIAPER_CONTENT = ["Urine", "Selles", "Mixte", "Sec"].freeze

  validates :content, inclusion: { in: DIAPER_CONTENT }, presence: true

  def content
    value_string
  end

  def content=(val)
    self.value_string = val
  end
end