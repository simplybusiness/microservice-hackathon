require_relative "../lib/borough_service.rb"

RSpec.describe BoroughService do


  it 'retrieves the borough given the name' do
    boroughs = [double(name: "Hackney"), double(name: "Islington")]
    borough_service = BoroughService.new(boroughs)
    expect(borough_service.find("Islington")).to eq(boroughs.last)
  end
end
