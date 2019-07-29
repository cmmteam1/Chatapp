class Userwork < ApplicationRecord
  
  belongs_to :user
  belongs_to :workspace
  paginates_per 5
end
