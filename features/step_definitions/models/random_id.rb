# Custom DataMagic data
module MyData
  def generate_id
    "sandbox_id_#{rand(36**10).to_s(36)}"
  end
end
DataMagic.add_translator MyData
