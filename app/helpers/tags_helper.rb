module TagsHelper
  def get_recipe_tags(recipe_id)
    RecipeTag.where(recipe_id: recipe_id).map { |rel| Tag.find(rel.tag_id) }
  end

  def get_gardening_tags(gardening_id)
    GardeningTag.where(gardening_id: gardening_id).map { |rel| Tag.find(rel.tag_id) }
  end

  def add_tags_to_recipe(tag_list, recipe_id)
    RecipeTag.where(recipe_id: recipe_id).destroy_all

    splitted_tag_list = split_tag_list(tag_list)
    splitted_tag_list.each do |tag|
      t = get_or_create_tag(tag)
      RecipeTag.create(tag_id: t.id, recipe_id: recipe_id)
    end

    destroy_orphans
  end

  def add_tags_to_gardening(tag_list, gardening_id)
    GardeningTag.where(gardening_id: gardening_id).destroy_all

    splitted_tag_list = split_tag_list(tag_list)
    splitted_tag_list.each do |tag|
      t = get_or_create_tag(tag)
      GardeningTag.create(tag_id: t.id, gardening_id: gardening_id)
    end

    destroy_orphans
  end

  def get_common_recipe_gardenings(recipe_id)
    GardeningTag.joins(
        'JOIN recipe_tags ON recipe_tags.tag_id = gardening_tags.tag_id')
      .where(:recipe_tags => {:recipe_id => recipe_id})
  end

  def get_common_gardening_recipes(gardening_id)
    RecipeTag.joins(
        'JOIN gardening_tags ON gardening_tags.tag_id = recipe_tags.tag_id')
      .where(:gardening_tags => {:gardening_id => gardening_id})
  end

  def split_tag_list(tag_list)
    tag_list.split(/,|;/).collect { |i| i.strip() }
  end

  def get_or_create_tag(tag)
    begin
      Tag.create(tag: tag)
    rescue ActiveRecord::RecordNotUnique
      Tag.where(tag: tag).first
    end
  end

  def destroy_orphans
    Tag.all.each do |t|
      next if RecipeTag.where(tag_id: t.id).any?
      next if GardeningTag.where(tag_id: t.id).any?
      t.destroy
    end
  end
end