# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    @titles ||= []
    @titles << movie["title"]
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  index1 = page.body.index(e1)
  index2 = page.body.index(e2)
  assert(index1 < index2, "#{index1} should be less than #{index2}")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split /,\s*/

  ratings.each do |rating|
    action = uncheck ? "uncheck" : "check"
    step %{I #{action} "ratings[#{rating}]"}
  end
end

Then /I should see all of the movies/ do
  @titles.each do |title|
    step %{I should see "#{title}"}
  end
end
