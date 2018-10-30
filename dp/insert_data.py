#!/usr/bin/env python
# -*- coding:utf-8 -*-

import time
import random
import pymysql

"""
生成车次信息并插入到数据库car_info表中
"""

def md5(s):
    """
    加密密码
    :param s:
    :return:
    """
    import hashlib
    if type(s) == type(''):
        m = hashlib.md5()
        m.update(s.encode("utf8"))
        return m.hexdigest()
    else:
        raise Exception("类型错误")

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

def before_insert_ck_exist(start_p, end_p, c_no):
    car_no = c_no[2:]
    car_no = "" + start_p[0] + end_p[0] + car_no + r'%'

    conn, cursor = connect_db()

    sql = "SELECT * FROM car_info WHERE car_no LIKE '%s'" % (car_no)
    cursor.execute(sql)
    if cursor.rowcount > 0:
        raise Exception("当天车次已插入！")

def insert_car_info(start_place, end_place, ti, price):
    """
    插入多条汽车线路数据
    :param start_place: 起始点
    :param end_place: 终点站
    :param ti: 日期
    :return:
    """
    # a = time.strftime('%Y%m%d', time.localtime())[2:]
    a = ti[2:]

    car_no = []   # 车次号
    for i in range(1, 31, 1):
        # tmp = 'CAR'
        tmp = '' + start_place[0] + end_place[0]
        if i < 10:
            tmp = tmp + a + '00' + str(i)
        elif i >= 10 and i < 100:
            tmp = tmp + a + '0' + str(i)
        else:
            tmp = tmp + a + str(i)
        car_no.append(tmp)

    # print(car_no)

    licence_plate = []  # 车牌号
    t = 30
    while t > 0:
        t1 = t
        for i in range(t1):
            b = '粤A-'
            for j in range(4):
                b1 = random.randint(0, 9)
                b = b + str(b1)
            if b not in licence_plate:
                t -= 1
                licence_plate.append(b)

    # print(licence_plate)

    # start_place = ['广州']
    # end_place = ['深圳']
    start_time = []
    # d0 = time.strftime('%Y-%m-%d', time.localtime())


    d01 = ti + '' + '060000'
    timeArray = time.strptime(d01, "%Y%m%d%H%M%S")
    d1 = time.mktime(timeArray)
    for i in range(30):
        start_time.append(str(time.strftime('%Y%m%d%H%M%S', time.localtime(d1))))
        d1 = d1 + 30 * 60

    # print(start_time)

    conn ,cursor = connect_db()

    flag = 1
    info = ''
    try:
        before_insert_ck_exist(start_place, end_place, ti)

        for i in range(len(car_no)):
            i2 = random.randint(30, 45)
            m1 = '0' + str(random.randint(1, 2))
            m2 = str(random.randint(0, 59))
            if int(m2) < 10:
                m2 = '0' + m2
            m = m1 + m2 + '00'

            sql = "insert into `car_info` value ('%s', '%s', '%s', '%s', %s, %s, %s)" % \
                  (car_no[i], licence_plate[i], start_place, end_place, start_time[i], m, i2 if i2 %2 == 0 else i2 + 1)
            print(sql)
            cursor.execute(sql)

        print("Done!")
        conn.commit()

        insert_price(start_place, end_place, price, ti)
    except Exception as e:
        print(e)
        conn.rollback()
        flag = 0
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        return flag, info

def insert_price(start_st, end_st, price, t):
    conn, cursor = connect_db()

    # lc_time = time.strftime("%Y%m%d", t)
    # b = time.mktime(time.strptime(lc_time, '%Y%m%d'))
    b = time.mktime(time.strptime(t, '%Y%m%d'))
    tom = time.strftime("%Y%m%d", time.localtime(b + 24*60*60))

    # a = time.strftime('%Y%m%d', time.localtime())[2:]
    a = t[2:]
    # car_no = 'CAR' + a  # 车次号
    car_no = '' + start_st[0] + end_st[0] + a


    try:

        sql = "INSERT INTO car_ticket_info(car_no, remain_ticket) SELECT car_no, limited_num FROM car_info WHERE start_station = '%s' AND end_station = '%s' " \
              "AND start_time > '%s' AND start_time < '%s' " %  (start_st, end_st, t, tom)
        print(sql)
        cursor.execute(sql)

        sql = "UPDATE car_ticket_info SET all_ticket = remain_ticket WHERE car_no > '%s'" % (car_no)
        print(sql)
        cursor.execute(sql)

        sql = "update car_ticket_info set price = %s where car_no in (select car_no from car_info where start_station = '%s' and end_station = '%s')" % \
              (price, start_st, end_st)
        print(sql)
        cursor.execute(sql)
        print("Done!")
        conn.commit()
    except Exception as e:
        print("ERROR!")
        print(e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

def insert_one_car(start_st, end_st, price, t):
    """
    插入制定汽车线路
    :param start_st:
    :param end_st:
    :param price:
    :param t:
    :return:
    """
    a = t[2:8]
    car_no = start_st[0] + end_st[0] + a + str(random.randint(101, 999))
    licence_plate = '粤B-' + str(random.randint(1001, 9999))

    conn, cursor = connect_db()

    try:
        i2 = random.randint(30, 45)
        i2 = i2 if i2 % 2 == 0 else i2 + 1
        m1 = '0' + str(random.randint(1, 2))
        m2 = str(random.randint(0, 59))
        if int(m2) < 10:
            m2 = '0' + m2
        m = m1 + m2 + '00'

        sql = "INSERT INTO car_info VALUES ('%s', '%s', '%s', '%s', %s, %s, %s)" % \
              (car_no, licence_plate, start_st, end_st, t, m, i2)
        print(sql)
        cursor.execute(sql)

        sql = "INSERT INTO car_ticket_info VALUES ('%s', %s, %s, %s)" % (car_no, price, i2, i2)
        print(sql)
        cursor.execute(sql)

        conn.commit()
    except Exception as e:
        print(e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()
        return car_no

def passenger_register(p_id, name):
    """
    乘客信息注册
    :param p_id:
    :param name:
    :return:
    """
    conn, cursor = connect_db()

    try:
        sql = "INSERT INTO passenger_info(p_id, p_name) VALUES ('%s', '%s')" % (p_id, name)
        print(sql)
        cursor.execute(sql)
        print("Done!")
        conn.commit()
    except Exception as e:
        print(e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# passenger_register('423695199601302361', '张三')

# insert_car_info('深圳', '广州', '20180108')
# insert_car_info('深圳', '广州', '20180109')
# insert_car_info('深圳', '广州', '20180110')
# insert_car_info('广州', '深圳', '20180109')
# insert_car_info('广州', '深圳', '20180108')
# insert_car_info('广州', '深圳', '20180110')
# insert_car_info('深圳', '广州', '20180111')
# insert_car_info('广州', '深圳', '20180111')

def account_register(id, password, t):
    """
    系统账户注册
    :param id:
    :param password:
    :param t: 级别标志
    :return:
    """
    pw = md5(password)
    print(pw)

    conn, cursor = connect_db()

    flag = 1
    info = ''
    try:
        sql = "SELECT * FROM account_info WHERE account = '%s'" % (id)
        cursor.execute(sql)
        if cursor.rowcount > 0:
            raise Exception("该用户名已存在，请重新创建！")

        sql = "INSERT INTO account_info VALUES ('%s', '%s', %s)" % (id, pw, t)
        cursor.execute(sql)
        conn.commit()
        print('创建成功！')
        info = '创建成功'
    except Exception as e:
        print(e)
        conn.rollback()
        info = str(e)
        flag = 0
    finally:
        cursor.close()
        conn.close()
        return flag, info

def showAllAccount():
    """
    查询所有账户信息
    :return:
    """
    conn, cursor = connect_db()
    print("开始查找")
    sql = "SELECT account, meaning FROM account_info ai, type_account_list t " \
          "WHERE ai.id_type = t.id_type ORDER BY ai.id_type , account"
    cursor.execute(sql)
    data = cursor.fetchall()
    return data



# account_register('user4', '123456', 1)



