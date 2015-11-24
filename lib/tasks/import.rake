
namespace :import do
	desc "imports data from a csv file"
	task :data => :environment do
		require 'csv'

	  CSV.foreach("db/appt_data.csv", headers: true, skip_blanks: true, skip_lines: /^(?:,\s*)+$/) do |row|
	  	start_time = row[0]
	    end_time = row[1]
	    first_name = row[2]
	    last_name = row[3]
	    comments = row[4]
	    Appointment.create!(
	    	start_time: start_time,
	    	end_time: end_time,
	    	first_name: first_name,
	    	last_name: last_name,
	    	comments: comments
	    	)
	  end
	end
end
