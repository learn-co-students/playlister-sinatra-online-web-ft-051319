class Genre < ActiveRecord::Base
    extend Findables::ClassMethods
    include Findables::InstanceMethods
  
     has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs
  end
  