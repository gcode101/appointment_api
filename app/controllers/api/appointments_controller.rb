module API
	class AppointmentsController < ApplicationController
		def index
			appointments = Appointment.all
			render json: appointments, status: 200
		end
	end
end
