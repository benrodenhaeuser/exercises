=begin
Write a method that takes a single String argument and returns a new string that
contains the original value of the argument, but the first letter of every word
is now capitalized.

You may assume that words are any sequence of non-blank characters, and that only
the first character of each word must be considered.
=end

# using capitalize
def word_cap(string)
  string.split(' ').map { |word| word.capitalize }.join(' ')
end

# more concisely:
def word_cap(string)
  string.split(' ').map(&:capitalize).join(' ')
end

# without built-in capitalize
def capitalize(word)
  word.chars.map.with_index do |char, index|
    if index == 0
      char.upcase
    else
      char.downcase
    end
  end.join
end

def word_cap(string)
  string.split(' ').map { |word| capitalize(word) }.join(' ')
end

p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'
