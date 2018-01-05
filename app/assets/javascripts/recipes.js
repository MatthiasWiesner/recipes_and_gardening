$( document ).ready(function() {
  if ($("#recipe_tags").length) {
    var $recipe_tags = $("#recipe_tags").selectize({
      persist: false,
      createOnBlur: true,
      create: true
    });
  
    var recipe_tags_s = $recipe_tags[0].selectize;
  
    $("#recipe_add_tag").on("click", function(e){
      e.preventDefault();
  
      var text = $.selection();
      var cleared_text = text.replace(/[^a-zA-ZÀ-ÿ]/gm, "");
      if (cleared_text.length == 0) {
        return false;
      }
  
      recipe_tags_s.addOption({value: cleared_text, text: cleared_text});
      recipe_tags_s.addItem(cleared_text);
      recipe_tags_s.refreshItems();
    });
  }
});
