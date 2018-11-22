$(document).ready(function(){
    $("button").click(function(){
      $("button").hide();
        $.ajax({url: "demo_test.txt", success: function(result){
            $("button").hide();
        }});
    });
});