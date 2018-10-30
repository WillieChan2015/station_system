# -*- coding: utf-8 -*-
import json
import random
import time

import pymysql
from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

from dp import del_data
from dp import ticket_configure, insert_data, data_configure


# from django.template import RequestContext

# Create your views here.

def connect_db() -> pymysql:
    """
    连接数据库
    :return:
    """
    conn = pymysql.connect(host='127.0.0.1',
                           port=3306,
                           user='user1',
                           passwd='',
                           db='station_system',
                           charset='utf8')

    cursor = conn.cursor()
    return conn, cursor


def md5(s):
    import hashlib
    if isinstance(s, str):
        m = hashlib.md5()
        m.update(s.encode("utf8"))
        return m.hexdigest()
    else:
        raise Exception("类型错误")


def home(request):
    return render(request, 'login.html', {'str1': 'home'})


# @csrf_exempt
def login(request):
    if request.method == 'POST':
        user_name = request.POST.get('user_name')
        pswd = request.POST.get('pswd')

        if len(user_name) == 0 or len(pswd) == 0:
            return HttpResponseRedirect('/login/')
            # return render(request, 'login.html', {'str1': u"用户名或密码为空"})
        conn, cursor = connect_db()

        pswd = md5(pswd)

        try:
            sql = "SELECT id_type FROM account_info WHERE account = '%s' AND passwd = '%s'" % (user_name, pswd)
            cursor.execute(sql)
            u1 = cursor.fetchall()
            print(u1)

            if len(u1) == 0:
                # return HttpResponse(-1, content_type='text')
                # return HttpResponseRedirect('/login/')
                return render(request, 'login.html', {'str1': u"u1 == 0"})

            if u1[0][0] == 1:
                mon = int(time.strftime("%m", time.localtime()))
                mon_list = [i for i in range(mon, mon + 2, 1)]
                d = int(time.strftime("%d", time.localtime()))
                d_list = [i for i in range(d, d + 10, 1)]
                return render(request, 'index1.html', {'month_list': mon_list, 'day_list': d_list})
            elif u1[0][0] == 2:
                mon = int(time.strftime("%m", time.localtime()))
                mon_list = [i for i in range(mon, mon + 2, 1)]
                d = int(time.strftime("%d", time.localtime()))
                d_list = [i for i in range(d, d + 10, 1)]

                mon_list2 = [i for i in range(1, 13, 1)]
                d_list2 = [i for i in range(1, 32, 1)]

                hour_list = [i for i in range(24)]
                min_list = [i for i in range(60)]

                return render(request, 'index2.html', {
                    'month_list': mon_list,
                    'day_list': d_list,
                    'month_list_del': mon_list2,
                    'day_list_del': d_list2,
                    'hour_list': hour_list,
                    'min_list': min_list
                })

            else:
                return HttpResponseRedirect('/login/')
                # return render(request, 'login.html', {'str1': u"u1 != 1"})
        except Exception as e:
            print(e)
            return render(request, 'login.html', {'str1': u"异常"})
        finally:
            cursor.close()
            conn.close()
    else:
        return render(request, 'login.html', {'str1': u'请登录'})


def index(request):
    mon = int(time.strftime("%m", time.localtime()))
    mon_list = [mon]  # [i for i in range(mon, mon + 2, 1)]
    d = int(time.strftime("%d", time.localtime()))
    d_list = [i for i in range(d, d + 10, 1)]
    return render(request, 'index1.html', {'month_list': mon_list, 'day_list': d_list})


def index2(request):
    mon = int(time.strftime("%m", time.localtime()))
    mon_list = [i for i in range(mon, mon + 2, 1)]
    d = int(time.strftime("%d", time.localtime()))
    d_list = [i for i in range(d, d + 10, 1)]

    mon_list2 = [i for i in range(1, 13, 1)]
    d_list2 = [i for i in range(1, 32, 1)]

    hour_list = [i for i in range(24)]
    min_list = [i for i in range(60)]

    return render(request, 'index2.html', {
        'month_list': mon_list,
        'day_list': d_list,
        'month_list_del': mon_list2,
        'day_list_del': d_list2,
        'hour_list': hour_list,
        'min_list': min_list
    })


def redirect_home(request):
    """
    重定向登录页面
    :param request:
    :return:
    """
    return HttpResponseRedirect('/login/')


@csrf_exempt
def check_ticket(request):
    """
    查询车票数量
    :param request:
    :return:
    """
    start_s = request.POST.get('start_s')
    end_s = request.POST.get('end_s')
    year = request.POST.get('year')
    mon = request.POST.get('mon')
    day = request.POST.get('day')
    status = request.POST.get('status')
    if int(mon) < 10:
        mon = '0' + mon
    if int(day) < 10:
        day = '0' + day
    t1 = '' + year + mon + day  # + '000000'
    day = str(int(day) + 1) if int(day) + 1 >= 10 else '0' + str(int(day) + 1)
    t2 = '' + year + mon + day  # + '000000'
    conn, cursor = connect_db()

    if status == 'del':
        lc_time = t1
    else:
        lc_time = time.strftime("%Y%m%d%H%M%S", time.localtime())

    sql = "SELECT c.car_no, licence_plate, start_station, end_station, start_time, cost_time, limited_num, price, remain_ticket " \
          "FROM car_info c, car_ticket_info cti WHERE c.car_no = cti.car_no AND start_station = '%s' AND end_station = '%s' " \
          "AND c.car_no IN (SELECT car_no from car_info WHERE start_time > '%s' AND start_time < '%s' AND start_time > '%s')" % \
          (start_s, end_s, t1, t2, lc_time)

    cursor.execute(sql)
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return JsonResponse(data, safe=False)


@csrf_exempt
def check_re_al_pa_info(request):
    """
    查询改签或退票信息并返回
    :param request:
    :return:
    """
    p_id = request.POST.get('p_id')
    status = request.POST.get('status')

    # 查询可供改签的票（即已购买但未出行）
    conn, cursor = connect_db()
    if int(status) == 1:
        s2 = 2
        sql = "SELECT p_name, b.p_id, tk_no, b.car_no, licence_plate, start_station, end_station, start_time, price, buy_time " \
              "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c " \
              "WHERE b.p_id = p.p_id AND b.car_no = c.car_no AND b.car_no = cti.car_no " \
              "AND b.p_id = '%s' AND validity = %s" % (p_id, s2)

        cursor.execute(sql)
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return JsonResponse(data, safe=False)

    # 查询已改签和已购买但未出行的票
    else:
        sql = "SELECT p_name, b.p_id, tk_no, b.car_no, licence_plate, start_station, end_station, start_time, price, buy_time " \
              "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c " \
              "WHERE b.p_id = p.p_id AND b.car_no = c.car_no AND b.car_no = cti.car_no " \
              "AND b.p_id = '%s' AND validity = %s" % (p_id, 2)

        cursor.execute(sql)
        data1 = cursor.fetchall()

        # sql = "SELECT p_name, b.p_id, atk_no, al.car_no, licence_plate, start_station, end_station, start_time, price, alter_time " \
        #       "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c, alter_ticket_info al " \
        #       "WHERE b.p_id = p.p_id AND al.car_no = c.car_no AND al.car_no = cti.car_no AND b.p_id = al.p_id " \
        #       "AND b.p_id = '%s' AND validity = %s" % (p_id, s2)
        sql = "SELECT p_name, al.p_id, atk_no, al.car_no, licence_plate, start_station, end_station, start_time, price, alter_time " \
              "FROM passenger_info p, car_ticket_info cti, car_info c, alter_ticket_info al " \
              "WHERE al.p_id = p.p_id AND al.car_no = c.car_no AND al.car_no = cti.car_no " \
              "AND al.p_id = '%s' AND al.status = %s" % (p_id, 1)

        cursor.execute(sql)
        data2 = cursor.fetchall()
        cursor.close()
        conn.close()
        data = data1 + data2
        return JsonResponse(data, safe=False)


@csrf_exempt
def check_all_pa_ti(request):
    """
    查询乘客所有购票信息（包括改签、退票）
    :param request:
    :return:
    """
    p_id = request.POST.get('p_id')

    # 查询已购买但未出行的票
    conn, cursor = connect_db()
    sql = "SELECT p_name, b.p_id, tk_no, b.car_no, licence_plate, start_station, end_station, start_time, price, buy_time, meaning " \
          "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c, status_info s " \
          "WHERE b.p_id = p.p_id AND b.car_no = c.car_no AND b.car_no = cti.car_no AND s.status = b.validity " \
          "AND b.p_id = '%s' AND validity = %s" % (p_id, 2)

    cursor.execute(sql)
    data1 = cursor.fetchall()

    # 查询已改签的票
    # sql = "SELECT p_name, b.p_id, atk_no, al.car_no, licence_plate, start_station, end_station, start_time, price, alter_time, meaning " \
    #       "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c, alter_ticket_info al, status_info s " \
    #       "WHERE b.p_id = p.p_id AND al.car_no = c.car_no AND al.car_no = cti.car_no AND b.p_id = al.p_id AND s.status = al.status " \
    #       "AND b.p_id = '%s' AND validity = %s" % (p_id, 1)

    sql = "SELECT p_name, al.p_id, atk_no, al.car_no, licence_plate, start_station, end_station, start_time, price, alter_time, meaning " \
          "FROM passenger_info p, car_ticket_info cti, car_info c, alter_ticket_info al, status_info s " \
          "WHERE al.p_id = p.p_id AND al.car_no = c.car_no AND al.car_no = cti.car_no AND s.status = al.status " \
          "AND al.p_id = '%s' AND al.status = %s" % (p_id, 1)

    cursor.execute(sql)
    data2 = cursor.fetchall()

    # 查询已退的票
    sql = "SELECT p_name, r.p_id, return_ticket_no, r.car_no, licence_plate, start_station, end_station, start_time, price, return_time, meaning " \
          "FROM ticket_buy_info b, passenger_info p, car_ticket_info cti, car_info c, return_ticket_info r, status_info s " \
          "WHERE b.p_id = p.p_id AND r.car_no = c.car_no AND r.car_no = cti.car_no AND b.p_id = r.p_id AND s.status = r.status " \
          "AND b.p_id = '%s' AND validity = %s" % (p_id, -2)

    cursor.execute(sql)
    data3 = cursor.fetchall()

    cursor.close()
    conn.close()
    data = data1 + data2 + data3
    return JsonResponse(data, safe=False)


@csrf_exempt
def buy_ticket(request):
    """
    购票
    :param request:
    :return:
    """
    p_id = request.POST.get('p_id')
    car_no = request.POST.get('car_no')
    name = request.POST.get('name')
    # flag = 0
    # info = ''
    if len(p_id) < 18:
        flag = -1  # 身份证长度输入有误
        info = "身份证长度有误"

    else:
        t_no = "GP" + car_no[5:9] + car_no[3:5] + str(random.randint(1000, 9999))

        flag, info = ticket_configure.buy_ticket(p_id, name, car_no, t_no)

    return HttpResponse(json.dumps({'status': str(flag), 'info_': info}), content_type='application/json')


@csrf_exempt
def alter_ticket(request):
    p_id = request.POST.get('p_id')
    old_car_no = request.POST.get('old_car_no')
    name = request.POST.get('name')
    old_ticket_no = request.POST.get('ticket_no')
    new_car_no = request.POST.get('new_car_no')

    new_ticket_no = 'GQ' + new_car_no[5:9] + new_car_no[3:5] + str(random.randint(1000, 9999))

    flag, info = ticket_configure.alter_ticket(p_id, name, old_car_no, new_car_no, old_ticket_no, new_ticket_no)

    return JsonResponse({'status': str(flag), 'info_': info}, safe=False)


@csrf_exempt
def return_ticket(request):
    """
    退票
    :param request:
    :return:
    """
    p_id = request.POST.get('p_id')
    car_no = request.POST.get('car_no')
    # name = request.GET.get('name')
    ticket_no = request.POST.get('ticket_no')

    flag, info = ticket_configure.return_ticket(p_id, car_no, ticket_no)
    return JsonResponse({'status': str(flag), 'info_': info}, safe=False)


@csrf_exempt
def del_all_car(request):
    """
    删除某天某线路所有数据
    或批量增加当天该线路的车次
    :param request:
    :return:
    """
    start_s = request.POST.get('start_s')
    end_s = request.POST.get('end_s')
    year = request.POST.get('year')
    mon = request.POST.get('mon')
    day = request.POST.get('day')
    # status = request.GET.get('status')
    # price = request.GET.get('price')

    if int(mon) < 10:
        mon = '0' + mon
    if int(day) < 10:
        day = '0' + day

    t = '' + year + mon + day

    flag, info = del_data.del_day_car(start_s, end_s, t)
    re_data = {
        'flag': flag,
        'info_': info
    }

    return JsonResponse(re_data, safe="False")


@csrf_exempt
def del_one_car(request):
    """
    删除一条数据
    :param request:
    :return:
    """
    car_no = request.POST.get('car_no')
    flag, info = del_data.del_one_car(car_no)

    return JsonResponse({'status': flag, 'info_': info}, safe='False')


def ck_by_car_no(car_no):
    conn, cursor = connect_db()
    sql = "SELECT c.car_no, licence_plate, start_station, end_station, start_time, cost_time, limited_num, price, remain_ticket " \
          "FROM car_info c, car_ticket_info cti WHERE c.car_no = cti.car_no AND c.car_no = '%s' " % (car_no)
    cursor.execute(sql)
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return data


@csrf_exempt
def insert_many_car(request):
    start_s = request.POST.get('start_s')
    end_s = request.POST.get('end_s')
    year = request.POST.get('year')
    mon = request.POST.get('mon')
    day = request.POST.get('day')
    price = request.POST.get('price')

    if int(mon) < 10:
        mon = '0' + mon
    if int(day) < 10:
        day = '0' + day

    t = '' + year + mon + day

    conn, cursor = connect_db()
    data = []
    try:
        flag, info = insert_data.insert_car_info(start_s, end_s, t, int(price))
        if flag == 0:
            raise Exception(info)

        conn, cursor = connect_db()
        b = time.mktime(time.strptime(t, '%Y%m%d'))
        tom = time.strftime("%Y%m%d", time.localtime(b + 24 * 60 * 60))
        sql = "SELECT c.car_no, licence_plate, start_station, end_station, start_time, cost_time, limited_num, price, remain_ticket " \
              "FROM car_info c, car_ticket_info cti WHERE c.car_no = cti.car_no AND start_station = '%s' AND end_station = '%s' " \
              "AND start_time > '%s' AND start_time < '%s'" % \
              (start_s, end_s, t + '000000', tom + '000000')

        cursor.execute(sql)
        data = cursor.fetchall()
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()
        return JsonResponse(data, safe=False)


@csrf_exempt
def insert_one_car(request):
    start_s = request.POST.get('start_s')
    end_s = request.POST.get('end_s')
    year = request.POST.get('year')
    mon = request.POST.get('mon')
    day = request.POST.get('day')
    price = request.POST.get('price')
    hour = request.POST.get('hour')
    mins = request.POST.get('min')

    if int(mon) < 10:
        mon = '0' + mon
    if int(day) < 10:
        day = '0' + day
    if int(hour) < 10:
        hour = '0' + hour
    if int(mins) < 10:
        mins = '0' + mins

    t = '' + year + mon + day + hour + mins + '00'

    car_no = ''
    try:
        car_no = insert_data.insert_one_car(start_s, end_s, price, t)

    except Exception as e:
        print(e)
    finally:
        data = ck_by_car_no(car_no)
        return JsonResponse(data, safe=False)


@csrf_exempt
def check_account_info(request):
    # info = request.POST.get('check_account_info')
    # if info == 'check_account_info':
    #     pass
    data = insert_data.showAllAccount()
    # return HttpResponse(json.dumps(data))
    return JsonResponse(data, safe=False)


@csrf_exempt
def change_account_password(request):
    user_name = request.POST.get('user_name')
    new_pswd = request.POST.get('new_pswd')

    # flag = 1
    # info = ''

    if data_configure.check_account_level(user_name) == 2:
        info = "暂不能修改级别为管理员的密码"
        flag = 0

    else:
        info, flag = data_configure.account_change_pswd(user_name, new_pswd)

    return JsonResponse({'flag': flag, 'info_': info}, safe=False)


@csrf_exempt
def account_delete(request):
    user_name = request.POST.get('user_name')
    flag, info = del_data.del_account_by_name(user_name)

    return JsonResponse({'flag': flag, 'info_': info}, safe=False)


@csrf_exempt
def create_account(request):
    user_name = request.POST.get('user_name')
    passwd = request.POST.get('pswd')

    if data_configure.check_account_isExist(user_name):
        info = '账户名已存在，不能重复创建！'
        flag = 0
    else:
        flag, info = insert_data.account_register(user_name, passwd, 1)

    return JsonResponse({'flag': flag, 'info_': info}, safe=False)


@csrf_exempt
def check_account_isExist(request):
    user_name = request.POST.get("user_name")
    if data_configure.check_account_isExist(user_name):
        flag = 1
    else:
        flag = 0

    return JsonResponse({'flag': flag}, safe=False)
