class Reservation < ApplicationRecord
	#validation for check_in_date and check_out_date
	#Enum to set role
  enum status: [:booked, :approved, :completed]

  belongs_to :user
	belongs_to :listing

	#validations
	validates :user_id, presence: true
	validates :listing_id, presence: true
	validates :check_out_date, presence: true
	validates :check_in_date, presence: true
	validate :check_in_cannot_be_yesterday_and_backward, on: :create
	validate :check_out_must_be_after_check_in, on: :create
	validate :dates_not_available, on: :create



  def check_in_cannot_be_yesterday_and_backward
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "Check in must be today onwards")
    end
  end    

  def check_out_must_be_after_check_in
    if check_out_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "You should stay atleast 1 night :(")
    end
  end 

  def dates_not_available
    booked = false
    @startdate = check_in_date
    @enddate = check_out_date
  	Reservation.all.where(listing_id: listing_id).each do |reservation|
  		if (@startdate.between?(reservation.check_in_date, reservation.check_out_date) || @startdate.between?(reservation.check_in_date, reservation.check_out_date))||(@startdate == (reservation.check_in_date || reservation.check_out_date)) || (@enddate == (reservation.check_in_date || reservation.check_out_date))
  			booked = true
  		end
  	end
    if booked == true
      errors.add(:check_in_date, "Those dates are already taken. Try again!")
    end
  end
end
