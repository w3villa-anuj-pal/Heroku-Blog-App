class HomeController < ApplicationController
	def index
		redirect_to blogs_path if logged_in?
	end 
end