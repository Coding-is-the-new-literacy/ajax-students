class Post < ActiveRecord::Base
	belongs_to :student
  # Remember to create a migration!
end
