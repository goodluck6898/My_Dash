# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

require 'rubygems'
require 'oci8'

# Scheduler implementing Employee Lists
SCHEDULER.every '1y', :first_in => 0 do |job|
	begin
		conn = OCI8.new('oracle','oracle','192.168.3.8:1521/xe' )

		sql = "Select name, age from emp"

		cursor = conn.exec(sql) 
		
		cursor.define(1, String, 30)
		cursor.define(2, String, 30)

		rowitems = []

		while r = cursor.fetch()
			rowitems << {
				:label => r[0],
				:value => r[1]
			}
		end

		send_event('employees', { items: rowitems })

		cursor.close()
	end
	conn.logoff
end



# Scheduler implementing Rickshaw Graph
SCHEDULER.every '1y', :first_in => 0 do |job|
	begin
		conn = OCI8.new('oracle','oracle','192.168.3.8:1521/xe' )
	    
		sql = "Select * from emp_turnover"

		cursor = conn.exec(sql) 
		    
		series = []

		while r = cursor.fetch()
			series << {
				:name => r[0],
				:data => [ {x:1, y:r[1]}, {x:2, y:r[2]}, {x:3, y:r[3]}, {x:4, y:r[4]}, {x:5, y:r[5]}, {x:6, y:r[6]}, {x:7, y:r[7]}, {x:8, y:r[8]}, {x:9, y:r[9]}, {x:10, y:r[10]}, {x:11, y:r[11]}, {x:12, y:r[12]} ]
			}
		end

		send_event('rickshaw', series: series)

		send_event('barchart', series: series)

		cursor.close()
	end
	conn.logoff
end



