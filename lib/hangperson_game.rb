class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = "-" * @word.length
    @bad_guess_count = 0
  end

  attr_reader :guesses
  attr_reader :wrong_guesses
  attr_reader :word
  attr_reader :word_with_guesses
  
  def guess(letter)
    raise(ArgumentError) if letter == '' || letter == nil ||
     (letter.length > 1) || (letter =~ /[a-zA-Z]/) != 0
    
    letter.downcase!
    if @word.include? letter
      if @guesses.include? letter
        return false
      end
      @guesses += letter
      #  every letter of @word not in @guesses to "-" and set to @word_with_guesses
      p = Regexp.new("[^"+@guesses+"]")
      @word_with_guesses = @word.gsub(p,'-')
      return true
    else
      @bad_guess_count += 1
      if @wrong_guesses.include? letter
        return false
      end
      @wrong_guesses += letter
      return true
    end
  end
  
  def check_win_or_lose
    return :win if @word == @word_with_guesses
    return :lose if @bad_guess_count >= 7
    return :play
  end
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
