class RedditScraper

  attr_reader :question

  def initialize(question)
    @question = parse_input(question)
  end
 
  def parse_input(input)
    input.gsub(/[^A-Za-z]/, "+").gsub(/\++/, "+")
  end

  def normalize_user_query
    question.gsub(/\++/, " ")
  end

  def search
    question_url = "http://www.reddit.com/r/explainlikeimfive/search?q=" + 
                    self.question + "&restrict_sr=on&sort=relevance&t=all"
    Nokogiri::HTML(open(question_url))
  end

  def choose_question
    page = search
    first_question = page.css("a.title.may-blank").first
    return nil if first_question.nil?
    
    question_link = "http://reddit.com" + first_question['href']
    Nokogiri::HTML(open(question_link))
  end

  def choose_answer
    question_page = choose_question
    points = question_page.css('span.score.unvoted')
    # binding.pry
    return nil if points.empty?
    
    points = points.sort_by {  |p| p.text[0..-7].to_i }.reverse.first
    points.parent.parent.css("form div div.md").text
  end

  def valid_answer?
    (choose_question.nil? || choose_answer.nil?) ? false : true
  end

  def scrape
    valid_answer? ? choose_answer : nil
  end

end