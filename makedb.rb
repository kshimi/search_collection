# coding: utf-8
require 'simstring_pure'
require 'natto'
require 'pry'

ngram_builder = SimString::NGramBuilder.new(3)
db = SimString::Database.new(ngram_builder)
natto = Natto::MeCab.new

txt_files = Dir.glob("texts/*txt")
txt_files.each do |n|
  File.open(n, 'r') do |f|
    f.each do |l|
      natto.parse(l) do |word|
        db.add(word.surface) if word.surface.length > 3
      end
    end
  end
end

db.save('./texts.db')
