require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index	
end

get '/visit' do
	erb :visit
end

post '/visit' do
	c = Client.new params[:client]
	c.save
	
	@barber = c.name

	erb "Thank you, #{c.name}. We call you later!"
end

get '/users' do

	@show = Client.order "created_at DESC"
	erb :users
end







