class Channel < ApplicationRecord
  
  belongs_to :workspace

  has_many :invite, :dependent => :destroy
  has_many :user,  :through => :invite 

  has_many :messages, :dependent => :destroy
  # 
  validates_presence_of :ch_name
  validates_presence_of :purpose

end
