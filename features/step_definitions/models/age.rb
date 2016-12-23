# Custom DataMagic data
module MyData
  def date_of_birth(age)
    (Date.today << age.to_i * 12).strftime('%Y-%m-%d')
  end
end

DataMagic.add_translator MyData
