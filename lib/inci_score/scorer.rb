module InciScore
  class Scorer
    def initialize(catalog, components)
      @catalog = catalog
      @size = components.size.to_f
      @components = @catalog.select { |k,v| components.include?(k) }
    end

    def call
      hazards.reduce(&:+) / @size
    end

    private

    def hazards
      hazards = @components.values
      hazards.map do |h|
        index = hazards.index(h) 
        h / weight(index)
      end
    end

    def weight(index)
      return 1.0 if index.zero?
      Math::log(index * @size, 17)
    end
  end
end
