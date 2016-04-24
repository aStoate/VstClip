class Clip < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	acts_as_likeable

	validates :url, presence: true
end
