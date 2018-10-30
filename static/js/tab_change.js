/**
 * Created by Mr.C on 2018/3/2.
 */

$(document).ready(function () {
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
});
