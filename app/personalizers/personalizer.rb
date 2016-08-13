class Personalizer
  def self.for_all(objects)
    objects.each do |object|
      self.for(object)
    end
  end

  def self.for(object)
    new(object).personalize
  end
end
