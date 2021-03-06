#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select *from Barbers where name=?', [name]).length > 0
end
def seed_db db, barbers
	if !is_barber_exists? db, barber
		bd.execute 'insert into Barbers (name) values (?)', [barber]
	end
end
end
def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
	end
configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"phone" TEXT,
			"datestamp" TEXT,
			"barber" TEXT,
			"color" TEXT
		)'
	db.execute 'CREATE TABLE IF NOT EXOSTS
		"Barbers"
		(
		    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
		    "name" TEXT
		)'

	sedd_db db, ['Alla', 'Vika', 'Dasha', 'Ira', 'Katya']
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/About' do
	@error = 'something wrong!'
	erb :About
end

get '/visit' do
	erb :visit
end

post '/visit' do
	
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username =>'ВВЕДИТЕ ИМЯ!', 
		   :phone => 'ВВЕДИТЕ НОМЕР ТЕЛЕФОНА',
		   :datetime => 'Укажите точную дату и время!' }
	#для каждой пары ключ-значение
	#hh.each do |key, value|
	#if params[key] == ''
		#переменной error присвоить value из хеша hh
		#(a value из хеша hh это ссобщение об ошибке)
		# переменной error присвоить сообщение об ошибке
	#	@error = hh[key]
		#вернуть предстивление visit
	#	return erb :visit
	#end
	@error = hh.select  {|key,_| params[key] == ""}.values.join(", ")
	if @error != ''
		return erb :visit
	end

	db = get_db
	db.execute 'insert into Users (username, phone, datestamp, barber, color)
	 values ( ?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]
	
	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"
end
get '/showusers' do
	db = get_db

	@results = db.execute 'select * from Users order by id desc'
	
	erb :showusers
end
	
