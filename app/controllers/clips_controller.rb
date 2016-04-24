class ClipsController < ApplicationController

	before_action :find_clip, only: [:show, :edit, :update, :destroy, :like_clip, :unlike_clip]
	def index
		@clips = Clip.all.order("created_at DESC")
	end

	def new
		@clip = current_user.clips.build
	end

	def create
		@clip = current_user.clips.build(clip_params)
		if @clip.save
			redirect_to root_path
		else
			render 'new'
		end

	end

	def show
		user = current_user
	end

	def destroy
		@clip.comments.each do |c|
			c.destroy
		end
		@clip.destroy
		redirect_to root_path
	end

	def edit
	end
	
	def update
		#TODO: code to make sure cant like more than once
		if @clip.update(clip_params)
			redirect_to clip_path(@clip)
		else
			render 'edit'
		end
	end

	def like_clip
		@clip.like_count += 1
		@clip.save	
		current_user.like!(@clip)
		render 'show'
	end



	def unlike_clip
		@clip.like_count -= 1
		@clip.save
		current_user.unlike!(@clip)
		render 'show'
	end

	private

	def find_clip
		@clip = Clip.find(params[:id])
	end

	def clip_params
		params.require(:clip).permit(:title, :description, :url)
	end
end
