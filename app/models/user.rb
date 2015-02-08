class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 4 }

  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: "has to contain one number and one upper case letter" }

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.group_by { |r| r.beer.style }.map { |s, rs| [s, rs.map{|r| r.score}.sum / rs.size.to_f] }
    .sort_by { |x, y| y}.last.first
  end

  def favorite_brewery
    return nil if beers.empty?
    User.first.ratings.group_by {|r| r.beer.brewery }.map { |s, rs| [s, rs.map{|r| r.score}.sum / rs.size.to_f] }
    .last.first.name
  end
end
