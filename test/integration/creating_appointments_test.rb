require 'test_helper'

class CreatingAppointmentsTest < ActionDispatch::IntegrationTest

	setup { host! 'api.appointment-dev.com:3000' }

	test 'creates appointments' do
		post '/appointments',
			{ appointment:
					{start_time: '11/24/2015 09:15', end_time: '11/24/2015 09:20', last_name: 'Smith', first_name: 'John'}
			}.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 201, response.status
		assert_equal Mime::JSON, response.content_type

		appointment = json(response.body)
		# assert_equal appointment_url(appointment[:id]), response.location
	end

	test 'does not create invalid appointments' do
    post '/appointments',
      { appointment:
      	{ start_time: nil, end_time: '11/24/2015 09:20', last_name: 'Smith', first_name: 'John' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
