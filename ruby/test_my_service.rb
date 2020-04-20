require 'minitest/autorun'

def meaning_of_life
  6 * 9
end

describe "When asked the meaning of life, the universe and everything" do
  it "must be 42" do
    _(meaning_of_life).must_equal 42
  end
end
