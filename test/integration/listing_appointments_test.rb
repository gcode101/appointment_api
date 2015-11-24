require 'test_helper'

class ListingAppointmentsTest < ActionDispatch::IntegrationTest

	setup { host! 'api.appointment-dev.com:3000' }

	test 'returns list of all appointments' do
		get '/appointments'
		assert_equal 200, response.status
		refute_empty response.body
	end

	test 'returns appointments filtered by last_name' do
		bayley = Appointment.create!(start_time: "11/1/13 9:30", end_time: "11/1/13 9:35", first_name: "bayley", last_name: "keller")
		brenda = Appointment.create!(start_time: "11/1/13 11:00", end_time: "11/1/13 11:05", first_name: "brenda", last_name: "hardy")
		get '/appointments?last_name=keller'
		assert_equal 200, response.status

		appointments = json(response.body)
		names = appointments.collect { |z| z[:last_name]}
		assert_includes names, 'keller'
		refute_includes names, 'hardy'
	end

	test 'returns appointment by id' do
		appointment = Appointment.create!(start_time: "11/1/13 9:30", end_time: "11/1/13 9:35", first_name: "bayley", last_name: "keller")
		get "/appointments/#{appointment.id}"
		assert_equal 200, response.status

		appointment_response = json(response.body)
		assert_equal appointment.start_time, appointment_response[:start_time]
	end

	test 'returns appointments in JSON' do
		get '/appointments', {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
	end
end
