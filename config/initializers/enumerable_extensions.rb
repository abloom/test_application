class Hash
  def recursively_blank?
    self.all? do |key, value|
      if value.respond_to?(:recursively_empty?)
        value.recursively_blank?
      else
        value.blank?
      end
    end
  end
end

class Array
  def recursively_blank?
    self.all? do |obj|
      if obj.respond_to?(:recursively_empty?)
        obj.recursively_blank?
      else
        obj.blank?
      end
    end
  end
end
