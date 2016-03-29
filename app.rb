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
	@barbers = Barber.all
	#@barbers = Barber.order "created_at DESC" сортировка по дате создания
	erb :index	
end