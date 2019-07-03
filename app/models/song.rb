class Song < ActiveRecord::Base

  belongs_to :artist
  has_many :song_genres #the sequence in which these relationships are defined matters, this line must come before the line below
  has_many :genres, through: :song_genres

  def slug
    self.name.downcase.split(" ").join('-')
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(name)= ?",slug.split('-').join(" "))
  end

end
