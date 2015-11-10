class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :guesses
  attr_accessor :word
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @guesses = ''
    @wrong_guesses = ''
    @word = word.downcase
  end

  def guess letter
    raise ArgumentError unless letter =~ /[A-Za-z]/
    letter = letter.downcase
    return false if @guesses.include? letter or @wrong_guesses.include? letter
    is_valid = @word.include? letter
    if is_valid
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    true
  end

  def word_with_guesses
    retval = ''
    @word.chars do |letter|
      val = (@guesses.include? letter) ? letter : '-'
      retval << val
    end
    retval
  end

  def winner?
    winner = false
    
  end

  def check_win_or_lose
    winchars = 0
    @word.chars do |letter|
      winchars +=1 if @guesses.include? letter
    end
    return :win if (winchars == @word.length)
    return :play if @wrong_guesses.length < 7
    return :lose
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
