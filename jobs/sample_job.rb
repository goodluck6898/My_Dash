# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

require 'rubygems'
require 'oci8'

 # Scheduler implementing Pie Chart
SCHEDULER.every '1y', :first_in => 0 do |job|
	begin
		conn = OCI8.new('oracle','oracle','192.168.3.8:1521/xe' )
		sql = "Select * from emp_turnover where year='2014'"

		cursor = conn.exec(sql)

		r = cursor.fetch()

		data = [
			{ label: "Jan", value: r[1] },
			{ label: "Feb", value: r[2] },
			{ label: "Mar", value: r[3] },
			{ label: "Apr", value: r[4] },
			{ label: "May", value: r[5] },
			{ label: "Jun", value: r[6] },
			{ label: "Jul", value: r[7] },
			{ label: "Aug", value: r[8] },
			{ label: "Sep", value: r[9] },
			{ label: "Oct", value: r[10] },
			{ label: "Nov", value: r[11] },
			{ label: "Dec", value: r[12] },
		]

		send_event 'piechart',  { value: data }
	end
	conn.logoff
end