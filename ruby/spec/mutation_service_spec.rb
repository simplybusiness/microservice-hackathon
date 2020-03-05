require 'date'

def infection_rate_algorithm(current_rate, date)
  current_rate + 1
end

describe "Mutation Algorithm" do
  it "increments the infection rate every Friday" do
    expect(infection_rate_algorithm(1, Date.new(2020, 3, 6))).to eq(2)
  end

  context "Given the current infection rate is 2 and the date is a Friday" do
    it "increments the infection rate by 1" do
      expect(infection_rate_algorithm(2, Date.new(2020, 3, 6))).to eq(3)
    end
  end
end

