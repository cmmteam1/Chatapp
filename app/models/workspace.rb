class Workspace < ApplicationRecord
	
	has_many :channels, :dependent =>:destroy
		
	has_many :userwork,:dependent =>:destroy
	has_many :users, :through => :userwork

	# validates :workspace_name, {presence: true}
	validates_presence_of :workspace_name

end
