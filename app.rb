#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
	if @erro != ''
		return erb :visit
	end
	erb "OK, Имя посетителя #{@username}, телфон #{@phone}, указано время #{@datetime}, мастера #{@barber}, #{@color}."
end