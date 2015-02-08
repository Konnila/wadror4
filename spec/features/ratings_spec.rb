require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) {FactoryGirl.create :rating, user:user, beer:beer1}


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(1).to(2)

    expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(2)
  end

  it "User sees ratings on ratingspage" do
    visit ratings_path
    expect(page).to have_content "Amount of ratings: 1"

    expect(Rating.count).to eq(1)
  end

  it "User sees his own rating on userpage" do
     #not connected to this user
    FactoryGirl.create :user2
    FactoryGirl.create :rating, beer:beer1 #not connected to user

    expect(Rating.count).to eq(2)
    expect(user.ratings.count).to eq(1)

    visit user_path(user)
    expect(page).to have_content "Has made 1 rating"
  end

end