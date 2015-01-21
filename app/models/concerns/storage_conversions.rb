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

    def store_cents *args
      args.each do |attribute|
        define_method "#{attribute}_dollars" do
          cents = read_attribute(attribute) || 0
          cents / 100.0
        end

        define_method "#{attribute}_dollars=" do |value|
          write_attribute attribute, value.to_f * 100
        end
      end
    end

  end
end
