class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :destroy]

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    
    if @recipe_ingredient.valid?
      @recipe_ingredient.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def index
    @recipes = current_user.recipes
  end

  def edit
  end

  def update 
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(
      :title, :source,
      name: [], amount: [], unit_id: []
    ).merge(user_id: current_user.id)
  end

  def recipe_params
    params.require(:recipe).permit(:title, :source)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
