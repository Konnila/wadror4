require 'rails_helper'

describe Beer do
  it "beer is saved correctly" do
    beer = Beer.create name:"Karjala", style:"Lager"
    expect(beer.valid?).to be(true)
    expect(Beer.count).to be(1)
  end
  it "beer not saved without name" do
    beer = Beer.create style:"Lager"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to be(0)
  end
  it "beer not saved without style" do
    beer = Beer.create name:"bisse"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to be(0)
  end
end
