class TagsController < ApplicationController
	def index
		@tags = Tag.all
	end

	def create
		#???Logic - If listing already has that taggging, then fails.
		@tag = Tag.new(tag_params)
		if Tag.exists?(:name => @tag.name)
			# If tag exists, proceed to tagging that listing
			@tag_exist = Tag.find_by(name: @tag.name)
			@listing_tag = ListingTag.new
			@listing_tag.tag_id = @tag_exist.id
			@listing_tag.listing_id = tag_params[:listing_id]

			if ListingTag.exists?(:listing_id => @listing_tag.listing_id, :tag_id => @listing_tag.tag_id)
				redirect_to root_path
			else
			#saving listingtag
				if @listing_tag.save
					redirect_to user_path(current_user)
				else
					redirect_to root_path
				end
			end
		else
			if @tag.save
			#create listingtag with this tag to that listing
			@listing_tag = ListingTag.new
			@listing_tag.tag_id = @tag.id
			@listing_tag.listing_id = tag_params[:listing_id]

			#saving listingtag
				if @listing_tag.save
					redirect_to user_path(current_user)
				else
					redirect_to root_path
				end
			else
				redirect_to root_path
			end
		end
	end

	def show # /tags/:id
			@tag = Tag.find(params[:id])
			@tags = Tag.all
			@listing_tags = ListingTag.where(tag_id: 438)
	end

	private

	def tag_params
    params.require(:tag).permit!
  	end
end	