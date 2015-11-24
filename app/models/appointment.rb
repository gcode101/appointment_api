class Appointment < ActiveRecord::Base
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :last_name, presence: true
	validates :first_name, presence: true
end
