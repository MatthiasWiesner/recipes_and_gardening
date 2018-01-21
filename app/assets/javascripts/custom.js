$( document ).ready(function() {
  if ($(".edit_tags").length) {

    var $tags = $(".edit_tags").selectize({
      persist: false,
      createOnBlur: true,
      create: true
    });
  
    var tags_s = $tags[0].selectize;
  
    $(".add_tag").on("click", function(e){
      e.preventDefault();
  
      var text = $.selection();
      var cleared_text = text.replace(/[^a-zA-ZÀ-ÿ]/gm, "");
      if (cleared_text.length == 0) {
        return false;
      }
  
      tags_s.addOption({value: cleared_text, text: cleared_text});
      tags_s.addItem(cleared_text);
      tags_s.refreshItems();
    });
  };

  $('.show_small_pics').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    dots: true,
  });

  $('.markdown-tooltip').tooltipster({
    contentCloning: true,
    theme: 'tooltipster-shadow',
    interactive: true
  });
});
