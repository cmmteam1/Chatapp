class User < ApplicationRecord
    
    has_secure_password
    has_many :userwork,  :dependent => :destroy
    has_many :workspace, :through => :userwork
    has_many :invites,  :dependent => :destroy
    has_many :channels, :through => :invites
     
    has_many :messages, :dependent => :destroy
   validates :name, presence: true, length: { maximum: 255 }
    validates :email,{presence:true,uniqueness:true,length:{maximum:255}}
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true, length: {maximum: 255},
    format: { with: VALID_EMAIL_REGEX }
    validates :password,{presence: true, length: {minimum:6}}
    paginates_per 5
end