$(document).ready(function() {
    $(".login-link").live('click',function(){
        $.get("http://localhost:8080/api/login/url/facebook",function(data,status){
            alert("data:" + data + " - status" + status);
        });
    });
});