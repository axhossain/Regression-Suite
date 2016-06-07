class RandomEnglishWordsGenerator

  def initialize
    file = File.open("features/support/tools/wordsEn.txt", "r")
    @words = file.read.split(' ')
    @max = @words.length - 1
  end

  def sentence(words = 10)
    sentence = Array.new
    (1..words).each do
      sentence << get_single_word
    end
    return "#{sentence.join(' ')}."
  end

  def words(count = 3)
    words = Array.new
    (1..count).each do
      words << get_single_word
    end
    return words.join(' ')
  end

  def characters(count=20)
    sentence = Array.new
    word = get_single_word.capitalize
    sentence << word
    count = count - word.length
    while count > 0
      length = 0
      while length <= 0 || length > count
        case count
          when 1
            word = '.'
          when 2
            word = ' a'
          when 3
            word = ' be'
          else
            word = ' ' + get_single_word
        end
        length = word.length
      end
      sentence << word
      count = count - length
    end
    return "#{sentence.join}"
  end

  private

  def get_single_word
    @words[rand(@max)]
  end

end