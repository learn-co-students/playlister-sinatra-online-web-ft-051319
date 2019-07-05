class Artist < ActiveRecord::Base
    extend Findables::ClassMethods
    include Findables::InstanceMethods
  
     has_many :songs
    has_many :genres, through: :songs
  end