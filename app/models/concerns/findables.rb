module Findables

    module ClassMethods
     def find_by_slug(slug)
       self.all.select { |instance|
         instance.slug == slug
       }.first
     end
    end
 
    module InstanceMethods
     def slug
       self.name.downcase.gsub(" ","-")
     end
   end
 
  end