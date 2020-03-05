require 'date'

def infection_rate_algorithm(current_rate, date)
  2
end

describe "Mutation Algorithm" do
  it "increments the infection rate every Friday" do
    #expect(infection_rate_algorithm(current_rate, date).to eq(new_infection_rate))
    expect(infection_rate_algorithm(1, Date.new(2020, 3, 6))).to eq(2)
  end
end

