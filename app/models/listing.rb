class Listing < ApplicationRecord
	#enum verified in listing
	enum verification_status: [:not_verified, :verified]
	mount_uploaders :images, ImagesUploader

	belongs_to :user
	has_many :listing_tags, dependent: :destroy
	has_many :tags, through: :listing_tags, dependent: :destroy

	#for reservation
	has_many :reservations

	# for pg search


  	# pg_search_scope :search_by_name, against: [:name, :max_price, :country, :state, :bedroom, :bed, :bathroom, :max_guest]


	#scopes for filtering
	# scope :desired_max_price, -> (max_price) {where("max_price < ?", max_price)}
	# scope :created_before, ->(time) { where("created_at < ?", time) }

	# method to filter
	def self.search(form_name, form_max_price, form_country)
		if (form_name != "") && (form_name != nil)
			
	      self.where("lower(name) LIKE ?", "%#{form_name.downcase}%")
	      #ANOTHER WAY TO WRITE THIS:
	      # scope :name_search,  ->(form_name) {where ("lower(name) LIKE ?", "%#{form_name.downcase}%")}
	      # then call Listing.name_search(params[:yaydaydayda])
		elsif (form_max_price != "") && (form_max_price != nil)			
	      self.where("max_price <= ?", form_max_price)	
		elsif (form_country != "") && (form_country != nil)			
	      self.where("lower(country) LIKE ?", form_country.downcase)
	    else
	      self.all
	    end
	end
end