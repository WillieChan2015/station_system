/**
 * Created by Mr.C on 2018/1/8.
 */

$(document).ready(function () {
    /*
    // tab栏切换
    $("#tab1").find("li").bind('click', function (e) {
        if ($(e.target).hasClass('active')) {
            return
        }

        var li_list = $("#tab1").find("li");
        var i = 0;
        for (; i < li_list.length; i++) {
            if ($(e.target).data() == $(li_list[i]).children().data()) {
                $(li_list[i]).removeClass("active").addClass("active");
                $($(".main>div")[i]).removeClass('display');
            }
            else {
                $(li_list[i]).removeClass("active");
                $($(".main>div")[i]).removeClass('display').addClass('display');
            }
        }
        // $("#ti_show_info").empty();
        // $("#al_ti_show_info").empty();
    });

    // 主页tab切换
    $("#m1").find('li').click(function (e) {
        if ($(e.target).hasClass('active')) {
            return
        }

        var m_list = $("#m1").find('li');
        var li_list = $("#tab1").find("li");
        var i = 0;
        for (; i < m_list.length; i++) {
            if ($(e.target).data() == $(m_list[i]).children().data()) {
                $(li_list[i]).removeClass("active").addClass("active");
                $($(".main>div")[i]).removeClass('display');
            }
            else {
                $(li_list[i]).removeClass("active");
                $($(".main>div")[i]).removeClass('display').addClass('display');
            }
        }
        // $("#ti_show_info").empty();
        // $("#al_ti_show_info").empty();
    });
    */

    // 识别月份切换到匹配天数
    $("#month_del").change(function () {
        var i = 1;
        var mon_del = $("#month_del");
        var day_del = $("#day_del");
        var tmp = '';
        if (cp_day31(mon_del.val())) {
            day_del.empty();
            for (i = 1; i < 32; i++) {
                tmp = "<option value='" + i + "'>" + i + "</option>";
                day_del.append(tmp);
            }
        }
        else if (cp_day30(mon_del.val())) {
            day_del.empty();
            for (i = 1; i < 31; i++) {
                tmp = "<option value='" + i + "'>" + i + "</option>";
                day_del.append(tmp);
            }
        }
        else if (mon_del.val() == '2') {
            day_del.empty();
            for (i = 1; i < 29; i++) {
                tmp = "<option value='" + i + "'>" + i + "</option>";
                day_del.append(tmp);
            }
        }
    });

    // 查询某一天的车次记录
    $("#check_ti_del_all").click(function () {
        var del_year = $("#year_del").val();
        var del_mon = $("#month_del").val();
        var del_day = $("#day_del").val();
        var del_s = $("#s_del").val();
        var del_e = $("#e_del").val();

        if (del_s == "" || del_e == "") {
            $(".info-prompt-body p").text("").text("请输入完整的信息！");
            $(".info-prompt").modal("toggle");
            // alert("请输入完整的信息！");
            return
        }
        if (del_s == del_e) {
            $(".info-prompt-body p").text("起始点不能相同！！");
            $(".info-prompt").modal("toggle");
            return
        }
        // $("#delete_all").removeClass("display");
        $("#del_car_show").empty();
        $.post("/check_ticket/", {
            'start_s': del_s,
            'end_s': del_e,
            'year': del_year,
            'mon': del_mon,
            'day': del_day,
            'status': 'del'
        }, function (ret) {
            $.each(ret, function (i, item) {
                var tmp = "";
                tmp = tmp + "<tr>";
                $.each(item, function (i2, con) {
                    tmp = tmp + "<td>" + con + "</td>>";
                });

                tmp = tmp + "<td><button class='btn btn-primary btn-sm' onclick='del_one(this)' type='button'>删除</button></td></tr>";
                $("#del_car_show").append(tmp);
            });
            var l = $("#del_car_show").find("tr").length;
            if (l == 0) {
                $("#delete_all").removeClass("display").addClass("display");
            }
            else {
                $("#delete_all").removeClass("display");
            }
            $("#sum_l2").empty().append("共搜索到" + l + '条记录');
        });


    });

    $("#delete_all").click(function () {
        // var c = confirm("确定删除当天所有车次？");
        // if (c == false) {
        //     return
        // }

        $("#info-cfg-body").find("p").text('').text("确定删除当天所有车次？");
        $("#info-cfg").modal("toggle");
        $("#info-cfg-yes").unbind().click(function () {
            delete_all();
            $("#delete_all").removeClass("display").addClass("display");
        });
    });

    $("#add_many").click(function () {
        var adds_year = $("#year").val();
        var adds_mon = $("#month").val();
        var adds_day = $("#day").val();
        var adds_s = $("#st_s").val();
        var adds_e = $("#end_s").val();
        //noinspection JSJQueryEfficiency
        var price = $("#price").val();
        

        if (adds_s == "" || adds_e == "" || price == "") {
            // alert("请输入完整的信息！");
            $(".info-prompt-body p").text("").text("请输入完整的信息！");
            $(".info-prompt").modal("toggle");
            return
        }
        if (adds_s == adds_e) {
            $(".info-prompt-body p").text("起始点不能相同！！");
            $(".info-prompt").modal("toggle");
            return
        }
        var reg=/^\d+$/;
        if (!reg.test(price)) {
            $(".info-prompt-body p").text("").text("价格无效，请重新输入！");
            $(".info-prompt").modal("toggle");
            // alert("价格无效，请重新输入！");
            $("#price").val("");
            return
        }

        // var c = confirm("确定增加" + adds_year + '年' + adds_mon + '月' + adds_day + '日' + "当天所有车次？");
        // if (c == false) {
        //     return
        //
        $("#info-cfg-body").find("p").text('').html("确定增加<br>" + adds_year + '年' + adds_mon + '月' + adds_day + '日<br>'
            + adds_s + " → " + adds_e + "<br>当天所有车次？");
        $("#info-cfg").modal("toggle");
        $("#info-cfg-yes").unbind().click(function () {
            add_many_car(adds_s, adds_e, adds_year, adds_mon, adds_day, price);
        });

    });

    $("#clear_insert1").click(function () {
        $("#sum_l").empty();
        $("#add_many_show").empty();
        $("#st_s").val("");
        $("#end_s").val("");
        $("#price").val("");
        $("#clear_insert1").removeClass("display").addClass('display');
    });

    $("#add_one").click(function () {
        var add_year = $("#year2").val();
        var add_mon = $("#month2").val();
        var add_day = $("#day2").val();
        var add_s = $("#st_s2").val();
        var add_e = $("#end_s2").val();
        //noinspection JSJQueryEfficiency
        var price = $("#price2").val();
        var hour = $("#hour").val();
        var min = $("#min").val();

        if (add_s == "" || add_e == "" || price == "") {
            // alert("请输入完整的信息！");
            $(".info-prompt-body p").text("").text("请输入完整的信息！");
            $(".info-prompt").modal("toggle");
            return
        }
        if (add_s == add_e) {
            $(".info-prompt-body p").text("起始点不能相同！！");
            $(".info-prompt").modal("toggle");
            return
        }
        var reg=/^\d+$/;
        if (!reg.test(price)) {
            $(".info-prompt-body p").text("").text("价格无效，请重新输入！");
            $(".info-prompt").modal("toggle");
            // alert("价格无效，请重新输入！");
            $("#price2").val("");
            return
        }

        // var c = confirm("确定增加" + add_year + '年' + add_mon + '月' + add_day + '日' + "当天的车次？");
        // if (c == false) {
        //     return
        // }
        $("#info-cfg-body").find("p").text('').html("确定增加<br>" + add_year + '年' + add_mon + '月' + add_day + '日<br>'
            + add_s + " → " + add_e + "<br>价格" + price + "<br>该车次？");
        $("#info-cfg").modal("toggle");
        $("#info-cfg-yes").unbind().click(function () {
            add_one_car(add_s, add_e, add_year, add_mon, add_day, price, hour, min);
        });


    });
    $("#clear_insert2").click(function () {
        $("#sum_l_o").empty();
        $("#add_one_show").empty();
        $("#st_s2").val("");
        $("#end_s2").val("");
        $("#price2").val("");
        $("#clear_insert2").removeClass("display").addClass('display');
    });

    // 当时间地点改变时取消“全部删除”按钮
    $("#s_del, #e_del, #year_del, #month_del, #day_del").change(function () {
        $("#delete_all").removeClass("display").addClass("display");
    });

    // 账户管理窗口切换
    $("#act-1").click(function () {
        var act1 = $("#act-1");
        if (act1.hasClass('active')) {
            return
        }
        $("#act-2").removeClass('active');
        act1.removeClass('active').addClass('active');
        $(".account-cfg-add").removeClass('display').addClass('display');
        $(".account-cfg-manage").removeClass('display');
    });
    $("#act-2").click(function () {
        var act2 = $("#act-2");
        if (act2.hasClass('active')) {
            return
        }
        $("#act-1").removeClass('active');
        act2.removeClass('active').addClass('active');
        $(".account-cfg-manage").removeClass('display').addClass('display');
        $(".account-cfg-add").removeClass('display');
    });

    // 查询账户信息
    $("#btn_ck_account").click(function () {
        $("#account_show, #account_sum_l").empty();

        $.ajax({
            type: 'post',
            url: '/check_account_info/',
            success: function (data) {
                $.each(data, function (i, item) {
                    var tmp = "";
                    tmp = tmp + "<tr>" + "<td>" + (i + 1) + "</td>td>";
                    $.each(item, function (i2, con) {
                        tmp = tmp + "<td>" + con + "</td>>";
                    });

                    tmp = tmp + "<td><input type='radio' value='' name='account_radio'></td></tr>";
                    $("#account_show").append(tmp);
                });
                var l = $("#account_show").find("tr").length;
                $("#account_sum_l").append("总共有" + l + '条账户记录');
                account_radio_set();
            },
            error: function (jqXHR, status, e) {
                $(".info-prompt-body p").text("").html("出错！<br>" + status + "<br>" + e);
                $(".info-prompt").modal("toggle");
            }
        });
    });
    
    // 账户管理按钮
    $("#btn-deal").click(function () {
        var radio_checked = $('input[name="account_radio"]:checked');
        if (radio_checked.val() == undefined) {
            $(".info-prompt-body p").text("").text("未选择需要进行操作的账户");
            $(".info-prompt").modal("toggle");
            return
        }

        var deal_select = $('#account-deal');
        if (deal_select.val() == 'no_action') {
            $(".info-prompt-body p").text("").text("未选择需要进行的操作");
            $(".info-prompt").modal("toggle");
            return
        }

        var user_name = radio_checked.val();//$("input[name='account_radio']:checked").val();
        if (deal_select.val() == 'reset-pswd') {
            change_pswd(user_name);
        }
        else if (deal_select.val() == 'delete-account') {
            account_del(user_name)
        }
    });

    var reg = /^\w+$/;

    var success_icon = "<span class='glyphicon glyphicon-ok form-control-feedback'></span>";
    var warning_icon = "<span class='glyphicon glyphicon-warning-sign form-control-feedback'></span>";
    var error_icon = "<span class='glyphicon glyphicon-remove form-control-feedback'></span>";
    // 添加用户名输入框发生改变
    $("#user_name_add").change(function () {
        var name_input = $("#user_name_add");
        var name_div = $("#user_name_div");
        name_div.removeClass('has-success has-error has-warning has-feedback');
        name_div.find('span').remove();
        if (name_input.val().length < 2) {
            name_div.addClass('has-warning has-feedback');
            name_div.append("<span class='help-block'>用户名长度过短（2-12个字符）</span>").append(warning_icon);
        }
        else if (name_input.val().length > 12) {
            name_div.addClass('has-warning has-feedback');
            name_div.append("<span class='help-block'>用户名长度过长（2-12个字符）</span>").append(warning_icon);
        }
        else if (!reg.test(name_input.val())) {
            name_div.addClass('has-error has-feedback');
            name_div.append("<span class='help-block'>用户名不合法（由下划线、字母。数字组成）</span>").append(error_icon);
        }

        else {
            $.post('/check_account_isExist/', {'user_name': name_input.val()}, function (data) {
                var flag = data.flag;
                if (flag == 1) {
                    name_div.addClass('has-warning has-feedback');
                    name_div.append("<span class='help-block'>用户名已存在，请重新创建</span>").append(warning_icon);
                }
                else {
                    name_div.addClass('has-success has-feedback');
                    name_div.append(success_icon);
                }
            });
        }
    });
    // 创建密码检测
    $("#pswd_add").change(function () {
        var pswd_input = $("#pswd_add");
        var pswd_div = $("#pswd_div");
        pswd_div.removeClass('has-success has-error has-warning has-feedback');
        pswd_div.find('span').remove();
        if (pswd_input.val().length < 6) {
            pswd_div.addClass('has-warning has-feedback');
            pswd_div.append("<span class='help-block'>密码长度过短（6-18个字符）</span>").append(warning_icon);
        }
        else if (pswd_input.val().length > 12) {
            pswd_div.addClass('has-warning has-feedback');
            pswd_div.append("<span class='help-block'>密码长度过长（6-18个字符）</span>").append(warning_icon);
        }
        else if (!reg.test(pswd_input.val())) {
            pswd_div.addClass('has-error has-feedback');
            pswd_div.append("<span class='help-block'>密码不合法（由下划线、字母。数字组成）</span>").append(error_icon);
        }
        else {
            pswd_div.addClass('has-success has-feedback');
            pswd_div.append(success_icon);
        }
        var pswd_input_con = $("#pswd_add_confirm");
        if (pswd_input_con.val() != '') {
            pswd_input_con.change();
        }
    });
    // 确认密码
    $("#pswd_add_confirm").change(function () {
        var pswd_input = $("#pswd_add");
        var pswd_input_con = $("#pswd_add_confirm");
        var pswd_div_con = $("#pswd_confirm_div");
        pswd_div_con.removeClass('has-success has-error has-warning has-feedback');
        pswd_div_con.find('span').remove();
        if (pswd_input.val() != pswd_input_con.val()) {
            pswd_div_con.addClass('has-error has-feedback');
            pswd_div_con.append("<span class='help-block'>两次输入密码不一致</span>").append(error_icon);
        }
        else {
            pswd_div_con.addClass('has-success has-feedback');
            pswd_div_con.append(success_icon);
        }
    });
    $('input[type=radio][name="用户级别"]').change(function() {
        $("#user_level_div").find('span').remove();
    });

    // 确认创建账户按钮
    $("#btn-add-user").click(function () {
        var name_input = $("#user_name_add");
        var name_div = $("#user_name_div");
        var pswd_input = $("#pswd_add");
        var pswd_div = $("#pswd_div");
        var pswd_con_input = $("#pswd_add_confirm");
        var pswd_con_div = $("#pswd_confirm_div");
        // name_input.change();
        var flag_confirm = 1;
        if (name_input.val() == '' && !name_div.hasClass('has-success')) {
            name_div.removeClass('has-success has-error has-warning has-feedback');
            name_div.find('span').remove();
            name_div.addClass('has-warning has-feedback');
            name_div.append("<span class='help-block'>请输入用户名（2-12个字符）</span>").append(warning_icon);
            flag_confirm = 0;
        }
        if (pswd_input.val() == '' || pswd_con_input.val() == '' || !pswd_div.hasClass('has-success') || !pswd_con_div.hasClass('has-success')) {
            if (!pswd_div.hasClass('has-success') || !pswd_con_div.hasClass('has-success')) {
                pswd_input.change();
                pswd_con_input.change();
            }
            if (pswd_input.val() == '') {
                pswd_div.removeClass('has-success has-error has-warning has-feedback');
                pswd_div.find('span').remove();
                pswd_div.addClass('has-warning has-feedback');
                pswd_div.append("<span class='help-block'>请输入密码（6-18个字符）</span>").append(warning_icon);
            }
            if (pswd_con_input.val() == '') {
                pswd_con_div.removeClass('has-success has-error has-warning has-feedback');
                pswd_con_div.find('span').remove();
                pswd_con_div.addClass('has-warning has-feedback');
                pswd_con_div.append("<span class='help-block'>请确认密码（6-18个字符）</span>").append(warning_icon);
            }
            flag_confirm = 0;
        }
        if ($("input[name='用户级别']:checked").val() == undefined) {
            var user_level_div = $("#user_level_div");
            user_level_div.find('span').remove();
            user_level_div.append("<span class='help-block' style='color: red; margin-left: 50px'>请选择用户级别</span>");
            flag_confirm = 0;
        }
        if (flag_confirm == 1) {
            $.ajax({
                type:'post',
                url: '/create_account/',
                data: {
                    'user_name': name_input.val(),
                    'pswd': pswd_input.val()
                },
                success: function (data) {
                    if (data.flag == 1) {
                        $(".info-prompt-body p").text("创建成功！");
                        $(".info-prompt").modal("toggle");
                        name_div.removeClass('has-success has-error has-warning has-feedback');
                        name_div.find('span').remove();
                        pswd_div.removeClass('has-success has-error has-warning has-feedback');
                        pswd_div.find('span').remove();
                        pswd_con_div.removeClass('has-success has-error has-warning has-feedback');
                        pswd_con_div.find('span').remove();
                        name_input.val('');
                        pswd_input.val('');
                        pswd_con_input.val('');
                        $("#user_level_div").find('span').remove();
                        $('input:radio[name="用户级别"]').removeAttr('checked');
                    }
                    else {
                        $(".info-prompt-body p").html("创建失败！<br>失败信息如下<br>" + data.info_);
                        $(".info-prompt").modal("toggle");
                    }
                },
                error: function (xhr) {
                    $(".info-prompt-body p").html("错误！<br>错误信息如下<br>" + xhr);
                    $(".info-prompt").modal("toggle");
                }
            });
        }
    });
});


// 设置radio value值与设置改变radio事件
function account_radio_set() {
    $("#account-deal").prop('selectedIndex', 0);
    $('input[type=radio][name="account_radio"]').change(function() {
        $("#account-deal").prop('selectedIndex', 0);
    });

    // 为每个radio设置value值
    $.each($("#account_show").find("tr"), function(i, item) {
        $($(item).find("input")).val($($(item).find("td")[1]).html());
        if ($(item).children().eq(2).html() == "管理员") {
            $($(item).find("input")).attr("disabled","disabled");
        }
    });
}

function cp_day31(e) {
    var e2 = Number(e);
    var a = [1, 3, 5, 7, 8, 10, 12];
    for (var i = 0; i < a.length; i++) {
        if (a[i] == e2)
            return true
    }
    return false
}
function cp_day30(e) {
    var e2 = Number(e);
    var a = [4, 6, 9, 11];
    for (var i = 0; i < a.length; i++) {
        if (a[i] == e2)
            return true
    }
    return false
}

function del_one(e) {
    var a = $(e.parentNode).parent().children()[0];
    var car_no = a.innerHTML;

    $("#info-cfg-body").find("p").text('').text("确定删除该车次？");
    $("#info-cfg").modal("toggle");
    $("#info-cfg-yes").unbind().click(function () {
        del_one2(car_no, a);
    });

    // var c = confirm("确定删除该车次？");
    // if (c == false) {
    //     return
    // }
}
function del_one2(car_no, a) {
    $.post('/del_one_car/', {'car_no': car_no}, function (ret) {
        var f = ret.status;
        var info = ret.info_;
        if (f == '1') {
            $(".info-prompt-body p").text("").text("删除成功！");
            $(".info-prompt").modal("toggle");
            // alert("删除成功！");
            $(a).parent().remove();
            $("#sum_l2").empty().append("共搜索到" + $("#del_car_show").find("tr").length + '条记录');
        }
        else if (f == '0') {
            $(".info-prompt-body p").text("").html("删除失败！" + "<br>失败原因：<br>" + info);
            $(".info-prompt").modal("toggle");
            // alert("删除失败！" + "\n失败原因：\n" + info);
        }
    });
}

function delete_all() {
    var del_year = $("#year_del").val();
    var del_mon = $("#month_del").val();
    var del_day = $("#day_del").val();
    var del_s = $("#s_del").val();
    var del_e = $("#e_del").val();

    if (del_s == "" || del_e == "") {
        // alert("请输入完整的信息！");
        $(".info-prompt-body p").text("").text("请输入完整的信息！");
        $(".info-prompt").modal("toggle");
        return
    }

    var data_list = {
        'start_s': del_s,
        'end_s': del_e,
        'year': del_year,
        'mon': del_mon,
        'day': del_day,
        'status': '0'
    };

    $.post('/del_all_car/', data_list, function (ret) {
        if (ret.flag == '1') {
            $(".info-prompt-body p").text("").text("删除成功！");
            $(".info-prompt").modal("toggle");
            // alert("删除成功！");
            $("#del_car_show").empty();
            $("#sum_l2").empty();
        }
        else {
            $(".info-prompt-body p").text("").html("删除失败！<br>" + ret.info_);
            $(".info-prompt").modal("toggle");
            // alert("删除失败！\n" + ret.info_);
        }
    });
}

function add_many_car(adds_s, adds_e, adds_year, adds_mon, adds_day, price) {
    $("#clear_insert1").removeClass("display");
    $("#add_many_show").empty();
    $.post("/insert_many_car/", {
        'start_s': adds_s,
        'end_s': adds_e,
        'year': adds_year,
        'mon': adds_mon,
        'day': adds_day,
        'price': price,
        'status': '1'
    }, function (ret) {
        $.each(ret, function (i, item) {
            var tmp = "";
            tmp = tmp + "<tr>";
            $.each(item, function (i2, con) {
                tmp = tmp + "<td>" + con + "</td>>";
            });

            tmp = tmp + "<td><button class='btn btn-primary btn-sm' onclick='del_one(this)' type='button'>删除</button></td></tr>";
            $("#add_many_show").append(tmp);
        });
        $("#sum_l").empty().append("共增加了" + $("#add_many_show").find("tr").length + '条记录');
        // alert("完成");
        $(".info-prompt-body p").text("").text("增加完成！");
        $(".info-prompt").modal("toggle");
    });
}

function add_one_car(add_s, add_e, add_year, add_mon, add_day, price, hour, min) {
    $("#clear_insert2").removeClass("display");
    $("#add_one_show").empty();
    $.post("/insert_one_car/", {
        'start_s': add_s,
        'end_s': add_e,
        'year': add_year,
        'mon': add_mon,
        'day': add_day,
        'price': price,
        'hour': hour,
        'min': min
    }, function (ret) {
        $.each(ret, function (i, item) {
            var tmp = "";
            tmp = tmp + "<tr>";
            $.each(item, function (i2, con) {
                tmp = tmp + "<td>" + con + "</td>>";
            });

            tmp = tmp + "<td><button class='btn btn-primary btn-sm' onclick='del_one(this)' type='button'>删除</button></td></tr>";
            $("#add_one_show").append(tmp);
        });
        $("#sum_l_o").empty().append("共增加了" + $("#add_one_show").find("tr").length + '条记录');
        $(".info-prompt-body p").text("").text("增加完成！");
        $(".info-prompt").modal("toggle");
        // alert("完成");
    });
}

function change_pswd(user_name) {
    $(".change-pswd-label").text('').html("请输入对账户名为 " + user_name + " 重置的密码：</label><br>" +
        "<label>密码可由字母、数字、下划线组成，长度大于6位");
    $("#change_pswd_model").modal("toggle");
    $(".change-pswd-confirm").unbind().click(function () {
        var new_pswd = $("input[name='change_pswd_input']");
        $("#alert-warn").remove();
        if (new_pswd.val() == '') {
            $("#change_pswd_body").append("<div id='alert-warn' class='alert alert-danger alert-dismissable' role='alert'>" +
                "<button class='close' type='button' data-dismiss='alert'>&times;</button>请输入密码！</div>");
            return
        }
        var reg = /^\w+$/; // 判断密码是否为数字字母以及下划线组成

        if (new_pswd.val().length < 6) {
            $("#change_pswd_body").append("<div id='alert-warn' class='alert alert-danger alert-dismissable' role='alert'>" +
                "<button class='close' type='button' data-dismiss='alert'>&times;</button>密码长度过短！</div>");
            return
        }

        if (!reg.test(new_pswd.val())) {
            $("#change_pswd_body").append("<div id='alert-warn' class='alert alert-danger alert-dismissable' role='alert'>" +
                "<button class='close' type='button' data-dismiss='alert'>&times;</button>密码组成有误！</div>");
            return
        }
        $("#change_pswd_model").modal("toggle");
        new_pswd.val('');
        $.ajax({
            type: 'post',
            url: '/change_account_password/',
            data: {'user_name': user_name, 'new_pswd': new_pswd.val()},
            success: function (data) {
                if (data.flag == 1) {
                    $(".info-prompt-body p").text("").text("修改成功！");
                    $(".info-prompt").modal("toggle");
                }
                else {
                    $(".info-prompt-body p").text("").html("修改失败，错误信息如下<br>" + data.info_);
                    $(".info-prompt").modal("toggle");
                }
            },
            error: function (ret) {
                $(".info-prompt-body p").text("").html("修改失败，错误信息如下<br>" + ret);
                $(".info-prompt").modal("toggle");
            }
        });
    });

    $(".change-pswd-no").unbind().click(function () {
        $("input[name='change_pswd_input']").val('');
    });
}

function account_del(user_name) {
    $("#info-cfg-body").find("p").text('').html("确定删除该账户？<br>" + user_name);
    $("#info-cfg").modal("toggle");
    $("#info-cfg-yes").unbind().click(function () {
        $.ajax({
            type:'post',
            url: '/account_delete/',
            data: {'user_name': user_name},
            success: function (ret) {
                if (ret.flag == 1) {
                    $(".info-prompt-body p").text("").text("删除成功！");
                    $(".info-prompt").modal("toggle");

                    $("input[name='account_radio']:checked").parent().parent().remove();

                    var tmp = $("#account_show").find('tr');
                    $.each(tmp, function (i, item) {
                        $(item).find('td:first').text(i + 1);
                    });
                    $("#account_sum_l").html("总共有" + tmp.length + '条账户记录');
                    //$("#btn_ck_account").click();
                }
                else {
                    $(".info-prompt-body p").text("").html("删除失败，错误信息如下<br>" + ret.info_);
                    $(".info-prompt").modal("toggle");
                }
            },
            error: function (ret) {
                    $(".info-prompt-body p").text("").html("删除失败，错误信息如下<br>" + ret);
                    $(".info-prompt").modal("toggle");
                }
            });
    });
}
