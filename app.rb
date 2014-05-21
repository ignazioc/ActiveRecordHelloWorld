require 'active_record'


ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))
#ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
	:adapter  => 'sqlite3',
	:database => 'example.db'
	)


ActiveRecord::Schema.define do
	unless ActiveRecord::Base.connection.tables.include? 'customers'
		create_table :customers do |table|
			table.column :name,		:string
			table.column :surname,	:string
		end
	end
end



class Customer < ActiveRecord::Base

	def to_s
		return "#{surname} #{self.name} "
	end
end

unless Customer.find_by_name('Martin')
	customer = Customer.create(:name => "Martin", :surname => "Bob");
	customer.save
	puts "Saved #{customer}"
end

