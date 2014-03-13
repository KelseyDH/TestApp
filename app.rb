require "sinatra"
require "data_mapper"
require "./emailsender"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/registration.db")

enable :sessions



##Authentication code
helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end



  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', '']
  end
end



##contact form Class
class Contact

	include DataMapper::Resource

	property :id, Serial
	property :name, String
	property :address, String
	property :department, String

	property :note, Text

end

DataMapper.finalize

Contact.auto_upgrade!

get "/" do 
	erb :index, layout: :default
end


post '/contact' do
	Contact.create(name:params[:name],
					address:params[:address],
					department:params[:department],
					note:params[:note])
	
	emailsender = EmailSender.new(params[:name], params[:address], params[:department], params[:note])
	emailsender.send

	erb :thankyou, layout: :default
end

#Retrieves ID's from database
get "/listing" do
	@all_contacts = Contact.all
	protected!	

	erb :listing, layout: :default
end


get "/note/:id" do |id|
	@contact = Contact.get id
	erb :note, layout: :default
end

post "/note/:id" do |id|

	@contact = Contact.get id
	@contact.name = params[:name]
	@contact.address = params[:address]
	@contact.department = params[:department]
	@contact.note = params[:note]
	@contact.save
	redirect to("/listing")

end


##Deletes ID from database
get "/delete/:id" do |id|

	contact = Contact.get id
	protected!
	contact.destroy
	redirect to "/listing"
end


