require 'rails_helper'

describe "Beers page" do
  it "can add beer with valid name" do
    visit beers_path

    click_link "New Beer"
    fill_in('beer_name', with: 'bisse')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "can not add beer without a valid name" do
    visit beers_path

    click_link "New Beer"

    expect(Beer.count).to eq(0)
    expect(current_path).to eq(new_beer_path)

  end
end