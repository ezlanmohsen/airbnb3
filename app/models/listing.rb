class Listing < ApplicationRecord
	#enum verified in listing
	enum verification_status: [:not_verified, :verified]
	mount_uploaders :images, ImagesUploader

	belongs_to :user
	has_many :listing_tags, dependent: :destroy
	has_many :tags, through: :listing_tags, dependent: :destroy

	#for reservation
	has_many :reservations

end