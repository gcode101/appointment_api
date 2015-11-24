module API
	class AppointmentsController < ApplicationController
		respond_to :json

		def index
			@appointments = Appointment.all
			if last_name = params[:last_name]
				@appointments = @appointments.where(last_name: last_name)

			elsif first_name = params[:first_name]
				@appointments = @appointments.where(first_name: first_name)

			elsif start_time = params[:start_time]
				@appointments = @appointments.where(start_time: start_time)

			elsif end_time = params[:end_time]
				@appointments = @appointments.where(end_time: end_time)
			end

			render json: @appointments, status: 200
		end

		def show
			@appointment = Appointment.find(params[:id])
			render json: @appointment, status: :ok
		end

		def create
			appointment = Appointment.new(appointment_params)

			if appointment.save
				respond_with :api, appointment
			else
				render json: appointment.errors, status: 422
			end
		end

		def update
			appointment = Appointment.find(params[:id])
			if appointment.update(appointment_params)
				render json: appointment, status: 200
			else
				render json: appointment.errors, status: 422
			end
		end

		private
			def appointment_params
				params.require(:appointment).permit(:start_time, :end_time, :last_name, :first_name, :comments)
			end

	end
end
