FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Matti"
    password "Foobar2"
    password_confirmation "Foobar2"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end

  factory :beer2, class: Beer do
    name "anonymous"
    brewery
    style "Pilsner"
  end

  factory :beer3, class: Beer do
    name "anonymous"
    brewery
    style "Hefe"
  end

  factory :ratingsor, class: Rating do
    score 55
  end
end