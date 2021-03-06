require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
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
	@c = Client.new
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]

	if @c.save
		erb "Thank you, #{@c.name}. We call you later!"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/clients' do
	@show = Client.order "created_at DESC"
	erb :clients
end

get '/barber/:id' do
	id = params[:id]
	@barber = Barber.find params[:id]
	erb :barber
end

get '/clients/:id' do
	id = params[:id]
	@client = Client.find params[:id]
	erb :client
end



