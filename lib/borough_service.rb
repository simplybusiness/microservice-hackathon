class BoroughService
  def initialize(boroughs)
    @boroughs = boroughs
  end

  def find(borough_name)
    @boroughs.detect { |borough| borough.name == borough_name }
  end
end
