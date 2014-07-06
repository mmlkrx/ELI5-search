class RedditScraper

  attr_reader :question

  def initialize(question)
    @question = question.downcase.gsub(/\s+|\?|!/, "+") 
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

    points = question_page.css('span.score.unvoted').
      sort_by {  |p| p.text[0..-7].to_i }.reverse.first
    points.parent.parent.css("form div div.md").text
  end

  def scrape
    choose_question.nil? ? nil : choose_answer
  end

end