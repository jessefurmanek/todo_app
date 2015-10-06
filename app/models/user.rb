class User < ActiveRecord::Base
	has_many :todos

	validates_uniqueness_of :name
	before_save :downcase_name

	  #makes name lower-case
  def downcase_name
    if self.name
    	self.name = 	name.downcase
    end
  end

end
