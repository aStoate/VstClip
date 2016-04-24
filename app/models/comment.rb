class Comment < ActiveRecord::Base
	belongs_to :clip
	belongs_to :user

	validates :body, presence: true
end
