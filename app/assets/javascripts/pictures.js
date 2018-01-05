$( document ).ready(function() {
  $('.pictures_index_list').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    dots: true,
  });
  
  $('.pictures_edit_image').click(function(){
    var src = $(this).attr('src').split('?')[0];
    swal({
      imageUrl: src,
      animation: false,
      width: "100%"
    });
  });
});

