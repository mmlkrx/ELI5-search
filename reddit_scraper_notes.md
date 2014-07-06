scratch

1. search with user input "where is china"

page = Nokogiri::HTML(open("http://www.reddit.com/r/explainlikeimfive/search?q=where+is+china&restrict_sr=on&sort=relevance&t=all"))


2. select first match
question_link = "http://reddit.com" + page.css("a.title.may-blank").first['href']
question_page = Nokogiri::HTML(open(question_link))


3. select answer with most points

answer_block = question_page.css('span.score.unvoted').sort_by {  |p| p.text[0..-7].to_i }.reverse.first
#refactor above to .css(<comment div>).sort_by {|div| div.css(<span.score.unvoted>).text[0..-7].to_i }.reverse.first
answer_block.parent.parent.css("form div div.md").text
