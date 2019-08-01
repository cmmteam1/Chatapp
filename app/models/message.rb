class Message < ApplicationRecord
  
  belongs_to :channel
  belongs_to :user
  
  has_many :thread_messages, :dependent => :destroy
end
