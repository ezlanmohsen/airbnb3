class Tag < ApplicationRecord
	has_many :listing_tags
	has_many :listings, through: :listing_tags

	#to help with tagging in users#show form
	attr_accessor :listing_id
end