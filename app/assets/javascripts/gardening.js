$( document ).ready(function() {
  if ($("#gardening_tags").length) {
    var $gardening_tags = $("#gardening_tags").selectize({
      // plugins: ['remove_button'],
      persist: false,
      createOnBlur: true,
      create: true
    });
  
    var gardening_tags_s = $gardening_tags[0].selectize;
  
    $("#gardening_add_tag").on("click", function(e){
      e.preventDefault();
  
      var text = $.selection();
      var cleared_text = text.replace(/[^a-zA-ZÀ-ÿ]/gm, "");
      if (cleared_text.length == 0) {
        return false;
      }
  
      gardening_tags_s.addOption({value: cleared_text, text: cleared_text});
      gardening_tags_s.addItem(cleared_text);
      gardening_tags_s.refreshItems();
    });
  }
});
