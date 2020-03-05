class BoroughService
  def initialize(boroughs)
    @boroughs = boroughs
  end

  def find(borough_name)
    @boroughs.detect { |borough| borough.name == borough_name }
  end

  def apply_change_in_infections(borough_name, change_in_infections)
    borough = find(borough_name)
    borough.change_number_of_infected(change_in_infections)
  end
end
