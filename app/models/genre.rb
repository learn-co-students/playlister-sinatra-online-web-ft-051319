class Genre < ActiveRecord::Base

  has_many :song_genres #the sequence in which these relationships are defined matters, this line must come before the line below
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs #only once the has_many songs relationship has been established, only will this line work

  def slug
    self.name.downcase.split(" ").join('-')
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(name)= ?",slug.split('-').join(" "))
  end

end
