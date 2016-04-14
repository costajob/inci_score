module InciScore
  class Component
    attr_reader :hazard, :name

    def initialize(options = {})
      @hazard = options.fetch(:hazard) { 0 }
      @name = options.fetch(:name) { fail ArgumentError, 'missing name' }
      @desc = options.fetch(:desc) { "" }
    end

    def ==(c)
      return false unless c.instance_of?(self.class)
      name == c.name
    end
  end
end
