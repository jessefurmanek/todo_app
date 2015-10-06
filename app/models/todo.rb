class Todo < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :task
	validates_presence_of :user_id
	validates_presence_of :due_date
	
	validates :user, :presence => {:message => "User doesn't exist"}
	validates_inclusion_of :complete, in: [true, false]

end
