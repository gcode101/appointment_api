require 'test_helper'

class DeletingAppointmetsTest < ActionDispatch::IntegrationTest
  setup do
  	host! 'api.appointment-dev.com:3000'
    @appointment = Appointment.create(start_time: '11/24/2015 09:15', end_time: '11/24/2015 09:20', last_name: 'Smith', first_name: 'John')
  end

  test 'deletes existing appointment' do
    delete "/appointments/#{@appointment.id}"
    assert_equal 204, response.status
  end
end
