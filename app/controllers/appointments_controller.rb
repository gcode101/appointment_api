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
			start_time = appointment.start_time
			end_time = appointment.end_time

			if validate_time(start_time, end_time) && appointment.save
				respond_with appointment
			else
				render json: appointment.errors, status: 422
			end
		end

		def update
			appointment = Appointment.find(params[:id])
			start_time = appointment_params[:start_time]
			end_time = appointment_params[:end_time]

			if (validate_time(start_time, end_time)) && (appointment.update(appointment_params))
				render json: appointment, status: 200
			else
				render json: appointment.errors, status: 422
			end
		end

		def destroy
			appointment = Appointment.find(params[:id])
			appointment.destroy
			head 204
		end

		private
			def appointment_params
				params.require(:appointment).permit(:start_time, :end_time, :last_name, :first_name, :comments)
			end

			#it takes a starting and ending time from appt
			#returns true if start and end time doesn't overlap existing appt times
			def validate_time(start_time, end_time)
				time_now = Time.now.strftime("%m/%d/%Y %H:%M")
				appointments = Appointment.all
				today = start_time.split[0]
				today_appts = appointments.where(start_time: today)
				result = false

				if start_time > time_now
					if today_appts.length == 0
						return true
					end
					today_appts.each do |appt|
						if start_time <= appt.end_time && appt.start_time <= end_time
							return false
						else
							result = true
						end
					end#end of each loop
				end#end of if start_time
				result
			end

end

