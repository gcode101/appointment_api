require 'test_helper'

class UpdatingAppointmentsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.appointment-dev.com:3000'
    @appointment = Appointment.create!(start_time: '11/24/2015 09:15', end_time: '11/24/2015 09:20', last_name: 'Smith', first_name: 'John')
  end

  test 'successful update' do
    patch "/appointments/#{@appointment.id}",
      { appointment:
        { start_time: '11/26/2015 09:15', end_time: '11/26/2015 09:20', last_name: 'Smith', first_name: 'John'}
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal '11/26/2015 09:15', @appointment.reload.start_time
  end

  test 'unsuccessful update' do
    patch "/appointments/#{@appointment.id}",
      { appointment:
        { start_time: nil, end_time: '11/26/2015 09:20', last_name: 'Smith', first_name: 'John' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
  end
end
