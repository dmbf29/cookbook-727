class View
  def display(recipes)
    puts '=' * 40
    puts 'Here are your recipes:'
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1} | [#{x_mark}] | #{recipe.name} - #{recipe.description} -\nRating: #{recipe.rating} | Prep Time: #{recipe.prep_time}"
    end
    puts '=' * 40
  end

  def ask_for(something)
    puts "What is the #{something}?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe?"
    print '> '
    gets.chomp.to_i - 1
  end
end
