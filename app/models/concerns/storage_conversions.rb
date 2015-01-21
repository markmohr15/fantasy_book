module StorageConversions
  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def display_juice *args
      args.each do |attribute|
        define_method "#{attribute}_juice" do
          juice = read_attribute(attribute)
          if juice < -100
            juice
          else
            "+" + juice.to_s
          end
        end
      end
    end

    def display_line *args
      args.each do |attribute|
        define_method "#{attribute}_line" do
          line = read_attribute(attribute)
          if line < 0
            line
          elsif line == 0
            "Pk"
          else
            "+" + line.to_s
          end
        end
      end
    end

  end
end
