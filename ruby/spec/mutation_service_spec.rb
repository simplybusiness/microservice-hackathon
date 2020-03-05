require_relative '../../ruby/infection_rate_algorithm'

describe "Mutation Algorithm" do
  context "Given the current infection rate is 1 and the date is a Friday" do
    it "increments the infection rate by 1" do
      expect(infection_rate_algorithm(1, Date.new(2020, 3, 6))).to eq(2)
    end
  end

  context "Given the current infection rate is 2 and the date is a Friday" do
    it "increments the infection rate by 1" do
      expect(infection_rate_algorithm(2, Date.new(2020, 3, 6))).to eq(3)
    end
  end

  context "Given the current infection rate is 1 and the date is not a Friday" do
    it "does not increment the infection" do
      expect(infection_rate_algorithm(1, Date.new(2020, 3, 7))).to eq(1)
    end
  end
end

