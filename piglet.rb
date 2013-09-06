require 'rubygems'
# require 'debugger'
require 'sinatra'

def translate(phrase)
	# debugger
	phrasal = phrase
	phrase = phrase.downcase
	str = phrase.downcase
	words = phrase.scan(/\w+/)
	words.each {|letters| phrase = phrase.gsub(letters, piggy(letters))}
	ensure_caps(phrase, phrasal)
end 		 	
 
def piggy(word)
	letters = ""
	word.scan(/^[^aeiou]+/) {|l| letters = l}
	ulets = "" 
	word.scan(/^[^aeiou]+qu|qu/) {|l| ulets = l}
	if ulets.split(//).count > letters.split(//).count
		letters = ulets
	end
	word = word.split(//)
	word.push(word.shift(letters.split(//).count))
	word = word.join("") +'ay' 
end

def ensure_caps(str, phrase)
	caps = phrase.split(" ").map do |string| 
		string = string.scan(/\w/).join
		if string == string.capitalize
			1
		else
			0
		end
	end
	
	result = []
	str.split(" ").each_with_index do |word, idx|
		if caps[idx] == 1
			string = word.scan(/\w+/).join
			word.gsub!(string, string.capitalize)
			word.gsub!(word[0], word[0].upcase)
			result << word
		else
			result << word
		end
	end
	result.join(" ")
end


get '/' do
%q{<form method="post">
What do you want to translate to Pig Latin? <input type="text" name="name" />
<input type="submit" value="Go!" />
</form>}
end


post '/' do
"#{translate(params[:name])}!"
end
