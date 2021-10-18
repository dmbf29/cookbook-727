require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # 1. Ask the view for a name and description
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep time')
    # 2. Instantiate a recipe with the name and description
    recipe = Recipe.new(
      prep_time: prep_time,
      name: name,
      description: description,
      rating: rating
    )
    # 3. Add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display recipes
    display_recipes
    # as user for index
    index = @view.ask_for_index
    @cookbook.mark_as_done(index)
  end


  def destroy
    # 1. Display the recipes
    display_recipes
    # 2. Ask user via the view which recipe to delete (=> index)
    recipe_index = @view.ask_for_index
    # 3. Ask the cookbook to remove the recipe
    @cookbook.remove_recipe(recipe_index)
  end

  def import
    # ask the user for the ingredient
    ingredient = @view.ask_for('ingredient')
    # using the ingredient, search allrecipes for 5 recipes
    recipes = ScrapeAllrecipesService.new(ingredient).call
    # display to the user
    @view.display(recipes)
    # index = ask the user which number they want to save
    index = @view.ask_for_index
    # get the one recipe with the index
    recipe = recipes[index]
    # give the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  private

  def display_recipes
    # 1. Get all the recipes from the Cookbook
    recipes = @cookbook.all
    # 2. Ask the view to display the recipes
    @view.display(recipes)
  end
end
