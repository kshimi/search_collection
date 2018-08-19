require 'simstring_pure'
require 'awesome_print'
require 'readline'
require 'pry'

db = SimString::Database.load('./texts.db')
matcher = SimString::StringMatcher.new(db, SimString::CosineMeasure.new)

loop do
  word = Readline.readline("> ")
  result =  matcher.search(word, 0.5)
  keywords = unless result.empty?
               result.map { |w| " -e #{w}" }.join
             else
               word
             end
  system("rg #{keywords}")
end
