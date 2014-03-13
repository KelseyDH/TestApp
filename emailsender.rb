require "pony"


class EmailSender

	def initialize(name, address, department, note)

		@name = name
		@address = address
		@department = department
		@note = note
	end


		def send
			
			if @department == "technical"

						Pony.mail(  :to => "kelseyh@gmail.com",
									:from => @name,
									:subject => "Technical team! You got a message from #{@name}",
									:body =>"Email from: #{@name}" + @note,
						    		:via => :smtp,
				 					:via_options => {
				    				:address              => 'smtp.gmail.com',
								    :port                 => '587',
								    :enable_starttls_auto => true,
								    :user_name            => 'answerawesome',
								    :password             => 'Sup3r$ecret',
								    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
								    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
								    })
			elsif @department == "marketing"
			
						Pony.mail(  :to => "kelseyh@gmail.com",
									:from => @name,
									:subject => "Marketing team! You got a message from #{@name}",
									:body =>"Email from: #{@name}" + @note,
						    		:via => :smtp,
				 					:via_options => {
				    				:address              => 'smtp.gmail.com',
								    :port                 => '587',
								    :enable_starttls_auto => true,
								    :user_name            => 'answerawesome',
								    :password             => 'Sup3r$ecret',
								    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
								    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
								    })

			else @department == "sales"
						
						Pony.mail(  :to => "kelseyh@gmail.com",
									:from => @name,
									:subject => "Sales team! You got a message from #{@name}",
									:body =>"Email from: #{@name}" + @note,
						    		:via => :smtp,
				 					:via_options => {
				    				:address              => 'smtp.gmail.com',
								    :port                 => '587',
								    :enable_starttls_auto => true,
								    :user_name            => 'answerawesome',
								    :password             => 'Sup3r$ecret',
								    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
								    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
								    })

			end



		end

end