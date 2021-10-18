require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # array of instances of Recipe
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  # recipe is an instance of Recipe
  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # get the recipe
    recipe = @recipes[index]
    # mark it as done
    recipe.mark_as_done!
    # save the csv
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |attributes|
      # We need to push instances of Recipe inside of @recipes
      # anything that isnt a string, we need update b4 giving to .new
      # hash[key] = new_value
      attributes[:done] = attributes[:done] == 'true'
      recipe = Recipe.new(attributes)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
