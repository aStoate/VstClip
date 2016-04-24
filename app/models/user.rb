class User < ActiveRecord::Base
	has_many :clips
  acts_as_liker
  acts_as_follower
  acts_as_followable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
