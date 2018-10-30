/**
 * Created by M_C on 2018/1/5.
 */

$(document).ready(function () {
   $("#login_btn").click(function () {
       var user_name = $('input[name = "user_name"]').val();
       var pswd = $("input[name = 'pswd']").val();
       if (user_name.length == 0 || pswd.length == 0) {
           $(".login").append('<div class="alert alert-info alert-dismissable" role="alert">' +
               '<button class="close" type="button" data-dismiss="alert">&times;</button>' +
               '请输入账户/密码' +
               '</div>');
           return
       }
       $.post("login/", {
           'user_name': user_name,
           'pswd': pswd
       }/*, function (ret) {
           $(".alert").remove();
           if (ret == -1) {
               $(".login").append('<div class="alert alert-danger alert-dismissable" role="alert">' +
               '<button class="close" type="button" data-dismiss="alert">&times;</button>' +
               '请输入正确的账户/密码' +
               '</div>');
           }
           
       }*/)
   });

});
