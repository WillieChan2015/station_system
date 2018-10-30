#!/usr/bin/env python
# -*- coding:utf-8 -*-

import pymysql
import time

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

def del_day_car(start_s, end_s, t):
    """
    删除某天某线路所有车次信息
    :param start_s:
    :param end_s:
    :param t:
    :return:
    """
    t2 = str(int(t) + 1)

    conn, cursor = connect_db()

    sql = "DELETE FROM car_info WHERE start_station = '%s' AND end_station = '%s' " \
          "AND start_time > %s AND start_time < %s " % (start_s, end_s, t, t2)

    flag = 1
    info = ''
    try:
        print("开始删除")
        cursor.execute(sql)
        conn.commit()
        print("删除成功")
    except Exception as e:
        print(e)
        conn.rollback()
        flag = 0
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        return flag, info

def del_one_car(car_no):
    """
    删除一条车次数据
    :param car_no:
    :return:
    """
    conn, cursor = connect_db()

    flag = 1
    info = ''
    sql = "DELETE FROM car_info WHERE car_no = '%s'" % (car_no)
    try:
        print("开始删除车次为" + car_no + "的记录")
        cursor.execute(sql)
        conn.commit()
        print("删除成功！")
    except Exception as e:
        conn.rollback()
        print(e)
        flag = 0
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        return flag, info

def del_account_by_name(user_name):
    conn, cursor = connect_db()
    sql = "DELETE FROM account_info WHERE account = '%s'" % user_name

    flag = 1
    info = ''

    try:
        print("开始删除", user_name)
        cursor.execute(sql)
        # f = cursor.rowcount
        conn.commit()
        info = '删除成功'
    except Exception as e:
        conn.rollback()
        print(e)
        info = str(e)
        flag = 0
    finally:
        print(info)
        cursor.close()
        conn.close()
        return flag, info
