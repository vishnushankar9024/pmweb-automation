$(function () {
  if ($(window).width() > 993){
    $('[data-toggle="tooltip"]').tooltip({
      trigger : 'hover'
    }); 
  }
 
});
window.onload = function() {
    $(".se-pre-con").fadeOut("slow");
  };
$(window).on('load', function(){
  $(".chat_alert").addClass('popout');
});

 // $(window).scroll(function(){
 //      if($(document).scrollTop() > 100) {
 //        $('#headerMenu').addClass('fixed-top');
 //        $('.navbar-collapse').css('top', '4px');
 //      } else {
 //        $('#headerMenu').removeClass('fixed-top');
 //        $('.navbar-collapse').css('top', '');
 //      }
 //  });

 $(document).ready(function(){
  // update date every minute
  todaysDateFunction();
    setInterval(function(){
      todaysDateFunction();
    }, 1000);

  // Greetings
  var greetings = generateGreetings();
  $('#greetings').text(greetings);

  setInterval(function(){
    var greetings = generateGreetings();
    $('#greetings').text(greetings);
  }, 3600000);  
    
  
  
  // Show more content
  $('#showMoreContent').click(function(){
    if ($('#hiddenContent').is(':visible')){
      $('#hiddenContent').slideUp();
      $('#showMoreContent').html('<i class="fas fa-plus-circle"></i> More Details');
    }
    else{
      $('#hiddenContent').slideDown();
      $('#showMoreContent').html('Show Less');
      $('#txtRegistrationNo_1').focus();
       $('html, body').animate({
          scrollTop: $("#txtRegistrationNo_1").offset().top
      }, 2000);
    }
  });

  // Table collapse in Role settings
  $('body').on('click', '.clickable', function() {

    $('#roleSettingsTable .collapse').not(this).each(function(){
         $(this).collapse('hide');
     });
     // $(this).collapse('show');
  });

  $('.filter_btn').on("show.bs.dropdown", function(event){

  $(".filter_list").click(false);
   event.stopPropagation();

    if($('.filter_list .dropdown-item').hasClass('show')){
     alert(1);
      e.stopPropagation();
    }
  });

  $('.dropdown-menu a.dropdown-toggle').on('click', function(e) {
    if (!$(this).next().hasClass('show')) {
      $(this).parents('.dropdown-menu').first().find('.show').removeClass('show');
    }
    var $subMenu = $(this).next('.dropdown-menu');
    $subMenu.toggleClass('show');


    $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
      $('.dropdown-submenu .show').removeClass('show');
    });


    return false;
  });


  $('.show_more').click(function(){
      $('#showMoreDiv').slideToggle();
       return false;
  });

 $(document).on('change', '.jqCombobox_floatingLabel', function (event) {
        
         var inputVal = $(this).jqxComboBox('val');

         if ($(this).jqxComboBox('getSelectedItem') == null && inputVal != '') {
             $(this).next().css({ 'top': '-17px', 'color': '#000' });
             return false;
         }
         if ($(this).jqxComboBox('getSelectedItem') == null && inputVal == '') {
             $(this).next().css({ 'top': '0', 'color': '#000' });
             return false;
         }
         if ($(this).jqxComboBox('getSelectedItem') != null) {
            $(this).next().css({ 'top': '-17px', 'color': '#c1c1c1' });
         }         
         else {
             $(this).jqxComboBox('selectIndex', -1);
             $(this).jqxComboBox('clearSelection');
             $(this).next().css({ 'top': '0', 'color': '#000' });
         }

     });

     $('.jqCombobox_floatingLabel').focusin(function () {
         $(this).next().css('top', '-17px');
     });
     $('.jqCombobox_floatingLabel').focusout(function () {
         if ($(this).jqxComboBox('getSelectedItem') != null) {
             $(this).next().css('top', '-17px');
         }
         else {
             $(this).next().css('top', '0');
             $(this).jqxComboBox('selectItem', "-1");
         }
     });

  $(document).on('change', '.jqxDropDownList_floatingLabel', function(event) {
       if ($(this).jqxDropDownList('getSelectedItem') != null){
          $(this).next().css({'top':'-17px', 'color':'#c1c1c1' });
       }
       else{
          $(this).next().css({'top':'0', 'color':'#000' });
       }
    
  });
  
  $('.jqxDateTimeInput_floatingLabel').on('change', function (event) {
       if ($(this).val() != ''){
          $(this).next().css('top', '-17px');
       }
       else{
          $(this).next().css('top', '0');
       }
    
  });

     $('.dvjqxCombobox_AddItems').on('change', function (event) {
         if ($(this).jqxComboBox('getSelectedItem') == null) {             
             $(this).siblings('.jqx_Combo_add_drop').show();
             $(this).siblings('.jqx_Combo_add_drop').find('p > span').html($(this).jqxComboBox('val'));
             $(this).jqxComboBox('close');
         } else {
             $(this).siblings('.jqx_Combo_add_drop').slideUp();
         }
     });
     $('.btn_jqxCombo_add').on('click', function (event) {
         var val = $(this).siblings('.txt_jqxCombo_add').find('span').html();
         $(this).parent().siblings('.dvjqxCombobox_AddItems').jqxComboBox('addItem', val);
         $(this).parent().siblings('.dvjqxCombobox_AddItems').jqxComboBox('selectItem', val);
         var type_id = $(this).parent().siblings('.dvjqxCombobox_AddItems').attr('type_id');
         SaveMasterRecord_AddComboList(type_id, val);
         $(this).parent().slideUp();
     });  

     $(document).mouseup(function (e) {
         var container = $('.jqx_Combo_add_drop');
         if (!container.is(e.target) && container.has(e.target).length === 0) {
             container.slideUp();
         }
     });
     $(document).on('keydown', '.dvjqxCombobox_AddItems ', function (e) {
         var keyCode = e.keyCode || e.which;
         var container = $('.jqx_Combo_add_drop');
         if (keyCode == 9) {
             container.slideUp();
         }
     });

});


function generateGreetings(){

  var currentHour = moment().format("HH");

  if (currentHour >= 3 && currentHour < 12){
      return "Good Morning";
  } else if (currentHour >= 12 && currentHour < 15){
      return "Good Afternoon";
  }   else if (currentHour >= 15 && currentHour < 20){
      return "Good Evening";
  } else if (currentHour >= 20 && currentHour < 3){
      return "Good Night";
  } else {
      return "Hello"
  }

}

function todaysDateFunction(){
    var date = Date(Date.now()); 
    $('#todaysDate').html(moment().format('DD/MM/YYYY, LTS')+'&nbsp;|&nbsp;');  
}

// Scroll to top
var btn = $('#scrollToTop');

$(window).scroll(function() {
  if ($(window).scrollTop() > 200) {
    btn.addClass('show_scroll');
    $('#stickyButton').addClass('sticky_button');
  } else {
    btn.removeClass('show_scroll');
    $('#stickyButton').removeClass('sticky_button');
  }
});

btn.on('click', function(e) {
  e.preventDefault();
  $('html, body').animate({scrollTop:0}, '300');
});