require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end

get '/' do
	erb :index	
end

get '/visit' do
	@barbers = Barber.all
	erb :visit
end

post '/visit' do
	@barbers = Barber.all

	@username = params[:username]
	@phone = params[:phone]
	@datestamp = params[:datestamp]
	@color = params[:color]
	@barber = params[:barber]
	
	if @phone != '' && @username != '' && @datestamp != ''
		Client.create :name => @username, :phone => @phone, :datestamp => @datestamp, :color => @color, :barber => @barber
	end
		
	hh = { :username => 'Enter your name',
			:phone => 'Enter your phone', 
			:datestamp => 'Enter date and time'
		 }
		 
	hh.each do |key, value|
	
		if params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end
	
	erb "Thank you, #{@username}. We call you later!"
end

get '/users' do

	@show = Client.order "created_at DESC"
	erb :users
end







