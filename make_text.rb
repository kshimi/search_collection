# coding: utf-8
require 'poppler'
require 'natto'
require 'pathname'
require 'pry'
require 'awesome_print'

BASE_DIR = '/Volumes/DATA/Documents/Bookscan_evernoted/'
natto = Natto::MeCab.new
all_files = Dir.glob("**/*.pdf", base: BASE_DIR)

#all_files.select { |n| n.match(/アーシュラ/) }.each do |n|
all_files.each do |n|
  txt_path = Pathname.new(n).sub_ext('txt')
  File.open("texts/#{txt_path.basename}", 'w') do |f|
    n_path = BASE_DIR + n
    f << n << "\n"
    
    doc = Poppler::Document.new(n_path)
    doc.each do |page|
      page_text = page.get_text.chomp.gsub(/\s/,'')
      natto.parse(page_text) do |word|
        f << word.surface
        f << "\n" if word.is_eos?
      end
    end
  end
end
