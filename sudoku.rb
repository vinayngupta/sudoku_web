require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions

get '/' do
	session[:last_visit] = Time.now.to_s
	"Last visit time has been recorded"
end

get '/last-visit' do
	"Previous visit to homepage: #{session[:last_visit]}"
end

def random_sudoku
	seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
	sudoku = Sudoku.new(seed.join)
	sudoku.solve!
	sudoku.to_s.chars
end

def puzzle(sudoku)
	sudoku
end

get '/' do
	sudoku = random_sudoku
	session[:solution] = sudoku
	@current_solution = puzzle(sudoku)
	erb :index
end

get '/solution' do
	@current_solution = session[:solution]
	erb :index
end

# get '/' do
# 	@current_solution = random_sudoku
# 	erb :index
# end