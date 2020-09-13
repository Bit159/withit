var header = $('#header_wrapper').offset().top;
$(window).scroll(function(){
    var window = $(this).scrollTop();
    if(header <= window) {
        $('#header_wrapper').addClass("fixed");
    } else {
        $('#header_wrapper').removeClass("fixed");
    }
});