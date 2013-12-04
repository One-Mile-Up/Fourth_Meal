module ItemsHelper

  def category_selection(category, categories)
     if category 
     select_tag "Categories", options_from_collection_for_select(categories, "id", "name", category.id), {:class => "btn btn-default dropdown-toggle" }
   else 
     select_tag "Categories", options_from_collection_for_select(categories, "id", "name"), {:class => "btn btn-default dropdown-toggle" }
    end 
  end
end
