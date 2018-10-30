/**
 * Created by Mr.C on 2018/1/6.
 */

var car_no_buy;
var person_id;
var nowDate = new Date();

$(document).ready(function () {
    setDay();

    // 获取车票信息
    $("#check_ti").click(function () {
        // 获取车票信息
        var start_s = $("#st_s").val();
        var ed_s = $("#end_s").val();
        var yr = $("#year").val();
        var m = $("#month").val();
        var d = $("#day").val();
        if (start_s === "" || ed_s === "") {
            $(".info-prompt-body p").text("").text("请输入完整的起始点！");
            $(".info-prompt").modal("toggle");
        }
        else if (start_s == ed_s) {
            $(".info-prompt-body p").text("起始点不能相同！！");
            $(".info-prompt").modal("toggle");
        }

        else {
            $("#ti_show_info").empty();
            $.post("/check_ticket/", {
                'start_s': start_s,
                'end_s': ed_s,
                'year': yr,
                'mon': m,
                'day': d
            }, function (ret) {
                $.each(ret, function (i, item) {
                    tmp = "";
                    // $("#ti_show_info").append("<tr>");
                    tmp = tmp + "<tr>";
                    $.each(item, function (i2, con) {
                        // $("#ti_show_info").append("<td>" + con + "</td>>");
                        tmp = tmp + "<td>" + con + "</td>>";
                    });
                    // $("#ti_show_info").append("<td><button class='btn btn-primary btn-sm' type='button'>预定</button></td>");
                    tmp = tmp + "<td><button class='btn btn-primary btn-sm' onclick='buy_ticket(this)' type='button'>预定</button></td></tr>";
                    $("#ti_show_info").append(tmp);
                });
                $("#sum_l").empty().append("共搜索到" + $("#ti_show_info").find("tr").length + '条记录');
            });

        }
    });

    // 改签页面乘客信息查询
    $("#check_pa_al").click(function () {
        var pid = $("#p_id_al").val();
        var status = '1';
        if (pid === "") {
            $(".info-prompt-body p").text("").text("请输入乘客的身份证号码！");
            $(".info-prompt").modal("toggle");
        }
            // alert("请输入乘客的身份证号码！");
        else if (pid.length != 18 || !/^\d+$/.test(pid)) {
            $(".info-prompt-body p").text("").text("请输入有效的身份证号码！");
            $(".info-prompt").modal("toggle");
            // alert('请输入有效的身份证号码！');
        }
        else {
            $("#pa_al_ti_show_info").empty();
            $.post("/check_re_al_pa_info/", {
                "p_id": pid,
                "status": status
            }, function (ret) {
                $.each(ret, function (i, item) {
                    tmp = "";
                    // $("#ti_show_info").append("<tr>");
                    tmp = tmp + "<tr>";
                    $.each(item, function (i2, con) {
                        // $("#ti_show_info").append("<td>" + con + "</td>>");
                        tmp = tmp + "<td>" + con + "</td>>";
                    });
                    // $("#ti_show_info").append("<td><button class='btn btn-primary btn-sm' type='button'>预定</button></td>");
                    tmp = tmp + "<td><input type='radio' value='";
                    tmp = tmp + i.toString() + "' name='alter_ticket'></td></tr>";
                    $("#pa_al_ti_show_info").append(tmp);
                });
                $("#sum_l3").empty().append("共搜索到" + $("#pa_al_ti_show_info").find("tr").length + '条可改签记录');
            });
        }
    });

    // 改签车票信息查询
    $("#check_ti2").click(function (e) {
        var start_s = $("#st_s2").val();
        var ed_s = $("#end_s2").val();
        var yr = $("#year2").val();
        var m = $("#month2").val();
        var d = $("#day2").val();
        if (start_s === "" || ed_s === "") {
            $(".info-prompt-body p").text("").text("请输入完整的起始点！");
            $(".info-prompt").modal("toggle");
        }
        else if (start_s == ed_s) {
            $(".info-prompt-body p").text("起始点不能相同！！");
            $(".info-prompt").modal("toggle");
        }

        else {
            $("#al_ti_show").empty();
            $.post("/check_ticket/", {
                'start_s': start_s,
                'end_s': ed_s,
                'year': yr,
                'mon': m,
                'day': d
            }, function (ret) {
                $.each(ret, function (i, item) {
                    tmp = "";
                    tmp = tmp + "<tr>";
                    $.each(item, function (i2, con) {
                        tmp = tmp + "<td>" + con + "</td>>";
                    });
                    tmp = tmp + "<td><button class='btn btn-primary btn-sm' onclick='alter_ti_ck(this)' type='button'>改签</button></td></tr>";
                    $("#al_ti_show").append(tmp);
                });
                $("#sum_l2").empty().append("共搜索到" + $("#al_ti_show").find("tr").length + '条记录');
            });
        }
    });

    // 退票页面乘客信息查询
    $("#re_check_pa").click(function () {
        var pid = $("#p_id_re").val();
        //var status = '2';
        if (pid === "") {
            $(".info-prompt-body p").text("").text("请输入乘客的身份证号码！");
            $(".info-prompt").modal("toggle");
        }
            // alert("请输入乘客的身份证号码！");
        else if (pid.length != 18 || !/^\d+$/.test(pid)) {
            $(".info-prompt-body p").text("").text("请输入有效的身份证号码！");
            $(".info-prompt").modal("toggle");
            // alert('请输入有效的身份证号码！');
        }
        else {
            $("#re_ti_show_info").empty();
            $.post("/check_re_al_pa_info/", {
                "p_id": pid,
                "status": '2'
            }, function (ret) {
                $.each(ret, function (i, item) {
                    tmp = "";
                    tmp = tmp + "<tr>";
                    $.each(item, function (i2, con) {
                        tmp = tmp + "<td>" + con + "</td>>";
                    });
                    tmp = tmp + "<td><button class='btn btn-primary btn-sm' type='button' onclick='return_ti_ck(this)'>退票</button></td></tr>";
                    $("#re_ti_show_info").append(tmp);
                });
                $("#sum_l4").empty().append("共搜索到" + $("#re_ti_show_info").find("tr").length + '条可退票记录');
            });
        }
    });

    // 乘客信息查询
    $("#ck_check_pa").click(function () {
        var pid = $("#p_id_ck").val();

        if (pid === "") {
            $(".info-prompt-body p").text("").text("请输入乘客的身份证号码！");
            $(".info-prompt").modal("toggle");
        }
            // alert("请输入乘客的身份证号码！");
        else if (pid.length != 18 || !/^\d+$/.test(pid)) {
            $(".info-prompt-body p").text("").text("请输入有效的身份证号码！");
            $(".info-prompt").modal("toggle");
            // alert('请输入有效的身份证号码！');
        }
        else {
            $("#ck_ti_show_info").empty();
            $.post("/check_all_pa_ti/", {
                "p_id": pid
            }, function (ret) {
                $.each(ret, function (i, item) {
                    tmp = "";
                    tmp = tmp + "<tr>";
                    $.each(item, function (i2, con) {
                        tmp = tmp + "<td>" + con + "</td>>";
                    });
                    tmp = tmp + "</tr>";
                    $("#ck_ti_show_info").append(tmp);
                });
                $("#sum_l5").empty().append("共搜索到" + $("#ck_ti_show_info").find("tr").length + '条记录');
            });
        }
    });

    // 输入购买信息关闭键
    $(".buy-quit").click(function () {
        //noinspection JSJQueryEfficiency
        if ($("input[name='p_name_buy']").val() != '' || $("input[name='p_id_buy']").val() != '') {
            if (!confirm("输入框中存在输入消息，是否放弃？")) {
                return false
            }
            $("input[name='p_name_buy']").val('');
            $("input[name='p_id_buy']").val('');
            return true
        }
    });
    // 输入购买信息确认键
    $(".buy-confirm").click(function () {
        var pname = $("input[name='p_name_buy']");
        var pid = $("input[name='p_id_buy']");

        //noinspection JSJQueryEfficiency
        $("#buy_model .modal-body .alert").remove();
        if (pid.val() == '' || pname.val() == '') {
            //noinspection JSJQueryEfficiency
            $("#buy_model .modal-body").append('<div class="alert alert-warning alert-dismissable" role="alert">' +
                '<button class="close" type="button" data-dismiss="alert">&times;</button>输入框中存在未完整的信息，请继续输入' +
                '</div>');
            return false;
        }
        if (pid.val().length != 18) {
            //noinspection JSJQueryEfficiency
            $("#buy_model .modal-body").append('<div class="alert alert-danger alert-dismissable" role="alert">' +
                '<button class="close" type="button" data-dismiss="alert">&times;</button>请输入有效的证件号码' +
                '</div>');
            return false;
        }
        buy_ticket2(pid.val(), pname.val());
        $("#buy_model").modal("toggle");
        pid.val('');
        pname.val('');

    });
    $("#buy_model").on('hidden.bs.modal', function () {
        //noinspection JSJQueryEfficiency
        $("#buy_model .modal-body .alert").remove();
    });
    // 改变月份监听
    $("#month").change(function () {
        setDayChange();
    });
});

function buy_ticket(e) {
    var a = e.parentNode;
    var b = $(a).parent().children()[0];
    car_no_buy = b.innerHTML;

    var a2 = a.previousSibling;
    if (a2.innerHTML <= 0) {
        $(".info-prompt-body p").text("").text("抱歉，该车次已售完，请选择其它车次！");
        $(".info-prompt").modal("toggle");
        return;
    }

    $("#buy_model").modal("toggle");
}
function buy_ticket2(aid, bname) {
    $.post('/buy_ticket/', {
        'p_id': aid,
        'name': bname,
        'car_no':car_no_buy
    }, function (ret) {
        var f = ret.status;
        var info = ret.info_;
        if (f == '0') {
            $(".info-prompt-body p").text("").text("购买成功！");
            $(".info-prompt").modal("toggle");
            $('#check_ti').click();
        }
        else if (f == '-1') {
            $(".info-prompt-body p").text("").html("购买失败！" + "<br>失败原因：<br>" + info);
            $(".info-prompt").modal("toggle");
            $('#check_ti').click();
        }
    });
}

// $('#dict').click(function(){
//           $.getJSON('/ajax_dict/',function(ret){
//               //返回值 ret 在这里是一个字典
//               $('#dict_result').append(ret.twz + '<br>');
//               // 也可以用 ret['twz']
//           })
// })

// 车票改签检查
function alter_ti_ck(e) {
    var list = $('input:radio[name="alter_ticket"]:checked');
    if (list.val() == undefined) {
        // alert("请选择要改签的车票！");
        $(".info-prompt-body p").text("").text("请选择要改签的车票！");
        $(".info-prompt").modal("toggle");
        return;
    }
    var a = list.parent().parent().children();
    var pid = a[1].innerHTML;
    var n = a[0].innerHTML;
    var car_no = a[3].innerHTML;
    var ti_no = a[2].innerHTML;

    var b = e.parentNode;
    var c = $(b).parent().children()[0];
    car_no_alter = c.innerHTML;

    if (car_no == car_no_alter) {
        $(".info-prompt-body p").text("").text("不能选择与原票相同的车次！");
        $(".info-prompt").modal("toggle");
        // alert("不能选择与原票相同的车次！");
        return;
    }
    
    $("#info-cfg-body").find("p").text('').html("确定修改该车次车票？<br>由" + car_no + '<br>改为' + car_no_alter);
    $("#info-cfg").modal("toggle");
    $("#info-cfg-yes").unbind().click(function () {
        alter_ticket(pid, n, ti_no, car_no, car_no_alter);
    });
}
// 车票改签
function alter_ticket(pid, n, ti_no, car_no, car_no_alter) {
    /*
    var list = $('input:radio[name="alter_ticket"]:checked');
    if (list.val() == undefined) {
        // alert("请选择要改签的车票！");
        $(".info-prompt-body p").text("").text("请选择要改签的车票！");
        $(".info-prompt").modal("toggle");
        return;
    }
    
    var a = list.parent().parent().children();
    var pid = a[1].innerHTML;
    var n = a[0].innerHTML;
    var car_no = a[3].innerHTML;
    var ti_no = a[2].innerHTML;

    var b = e.parentNode;
    var c = $(b).parent().children()[0];
    car_no_alter = c.innerHTML;

    if (car_no == car_no_alter) {
        $(".info-prompt-body p").text("").text("不能选择与原票相同的车次！");
        $(".info-prompt").modal("toggle");
        // alert("不能选择与原票相同的车次！");
        return;
    }

    var cf = confirm("确定修改该车次车票？\n由" + car_no + '\n改为' + car_no_alter);

    if (cf == false)
        return;
    */

    // $("#info-cfg-yes").unbind();
    $.post('/alter_ticket/', {
        'p_id': pid,
        'name': n,
        'ticket_no':ti_no,
        'old_car_no':car_no,
        'new_car_no':car_no_alter
    }, function (ret) {
        var f = ret.status;
        var info = ret.info_;
        if (f == '0') {
            // alert("改签成功！");
            $(".info-prompt-body p").text("").text("改签成功！");
            $(".info-prompt").modal("toggle");
        }
        else if (f == '-1') {
            $(".info-prompt-body p").text("").html("改签失败！" + "<br>失败原因：<br>" + info);
            $(".info-prompt").modal("toggle");
            // alert("改签失败！" + "\n失败原因：\n" + info);
        }
    });
}

// 退票前确认
function return_ti_ck(e) {
    var a = e.parentNode;
    var b = $(a).parent().children();

    var pid = b[1].innerHTML;
    var n = b[0].innerHTML;
    var car_no = b[3].innerHTML;
    var ti_no = b[2].innerHTML;

    $("#info-cfg-body").find("p").text('').html("确定退该车次车票？<br>" + car_no);
    $("#info-cfg").modal("toggle");
    $("#info-cfg-yes").unbind().click(function () {
        return_ticket(pid, n, ti_no, car_no);
    });
}
// 退票
function return_ticket(pid, n, ti_no, car_no) {
    /*
    var a = e.parentNode;
    var b = $(a).parent().children();

    var pid = b[1].innerHTML;
    var n = b[0].innerHTML;
    var car_no = b[3].innerHTML;
    var ti_no = b[2].innerHTML;
    
    var cf = confirm("确定退该车次车票？\n" + car_no);

    if (cf == false)
        return;
    */

    $.post('/return_ticket/', {
        'p_id': pid,
        'name': n,
        'ticket_no':ti_no,
        'car_no':car_no
    }, function (ret) {
        var f = ret.status;
        var info = ret.info_;

        if (f == '0') {
            // alert("退票成功！");
            $("#re_check_pa").click();
            $(".info-prompt-body p").text("").text("退票成功！");
            $(".info-prompt").modal("toggle");
        }
        else if (f == '-1') {
            $(".info-prompt-body p").text("").html("退票失败！" + "<br>失败原因：<br>" + info);
            $(".info-prompt").modal("toggle");
            // alert("退票失败！" + "\n失败原因：\n" + info);
        }
    });
}

// 设置日期
var day_sum_t = 0;
function setDay() {
    var mon_t = nowDate.getMonth() + 1; //$("#month");
    var day_t = nowDate.getDate(); // $("#day");
    var dj = $("#day");
    dj.html('');
    day_sum_t = 0;
    if (mon_t == 2 && day_t >= 24) {
        var i = nowDate.getDate();
        for (; i < 29; i++) {
            dj.append('<option value="' + i + '">' + i + '</option>');
            day_sum_t++;
        }
    }
    else if (day_sum_t < 5 && isBigMon(mon_t)) {
        var i2 = nowDate.getDate();
        for (; i2 < 32 && day_sum_t < 5; i2++) {
            dj.append('<option value="' + i2 + '">' + i2 + '</option>');
            day_sum_t++;
        }
    }
    else if (day_sum_t < 5 && isSmallMon(mon_t)) {
        var i3 = nowDate.getDate();
        for (; i3 < 31 && day_sum_t < 5; i3++) {
            dj.append('<option value="' + i3 + '">' + i3 + '</option>');
            day_sum_t++;
        }
    }
    if (day_sum_t < 5) {
        var mj = $("#month");
        mj.html('');
        mj.append('<option value="' + mon_t + '">' + mon_t + '</option>');
        mj.append('<option value="' + (mon_t + 1) + '">' + (mon_t + 1) + '</option>');
    }
}
function setDayChange() {
    var mon_t2 = $("#month");
    if (mon_t2.val() == (nowDate.getMonth() + 1)) {
        setDay();
    }
    else {
        var dj = $("#day");
        dj.html("");
        var i = 1;
        while (day_sum_t < 5) {
            dj.append('<option value="' + i + '">' + i + '</option>');
            i++;
            day_sum_t++;
        }
    }
}
function isBigMon(e) {
    var bm = [1, 3, 5, 7, 8, 10, 12];
    var i = 0;
    for (; i < bm.length; i++) {
        if (e == bm[i])
            return true
    }
    return false
}
function isSmallMon(e) {
    var bm = [2, 4, 6, 9, 11];
    var i = 0;
    for (; i < bm.length; i++) {
        if (e == bm[i])
            return true
    }
    return false
}
