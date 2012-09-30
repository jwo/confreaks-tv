module PresentersHelper
  def alpha_index highlight = ""
    results = []
    ('A'..'Z').to_a.each do |letter|
      if letter == highlight
        results << "<span class='large-stat'>" + link_to(letter, "##{letter}") + "</span>"
      else
        results << link_to(letter, "##{letter}")
      end
    end
    return results.join(" | ")
  end
end
