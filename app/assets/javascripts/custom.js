$(document).ready(function(){
  $('body').on('click', '.showreply', function(){
    $(this).siblings('.form-comment').toggle(300);
  });
});
