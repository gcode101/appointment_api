module API
	class AppointmentsController < ApplicationController

		def index
			appointments = Appointment.all
			if last_name = params[:last_name]
				appointments = appointments.where(last_name: last_name)
			end
			render json: appointments, status: 200
		end

		def show
			appointment = Appointment.find(params[:id])
			render json: appointment, status: :ok
		end
	end
end
