#!/usr/bin/env python
# -*- coding:utf-8 -*-

import pymysql
import time, random
from dp import insert_data

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

def check_pa_info_uniformity(p_id, name):
    """
    检查乘客姓名与身份证号码与数据库中所保存的是否一致
    :param p_id: 身份证号码
    :param name: 乘客姓名
    :return: 1——一致；0——不一致，抛出异常
    """
    conn, cursor = connect_db()
    flag = 1
    inf = ''
    try:
        sql = "SELECT * FROM passenger_info WHERE p_id = '%s' AND p_name = '%s'" % (p_id, name)
        cursor.execute(sql)

        if cursor.rowcount == 0:
            raise Exception("姓名与身份证不符，请重新输入")

    except Exception as e:
        print(e)
        flag = 0
        inf = str(e)
    finally:
        cursor.close()
        conn.close()
        return flag, inf

def buy_ticket(p_id, name, car_no, ticket_no):
    """
    购票
    :param p_id: 身份证号码
    :param name: 乘客姓名
    :param car_no: 车次号
    :param ticket_no: 车票单号
    :return:
    """
    conn, cursor = connect_db()

    sql = "SELECT * FROM passenger_info WHERE p_id = '%s'" % (p_id)

    cursor.execute(sql)

    if cursor.rowcount == 0:
        insert_data.passenger_register(p_id,name)
        print("创建乘客信息成功")
    else:
        cursor.close()
        conn.close()

    # conn, cursor = connect_db()

    flag = 0
    info = ''
    f = 0
    try:
        a, b = check_pa_info_uniformity(p_id, name)
        if a == 0:
            f = -2
            raise Exception(b)

        conn, cursor = connect_db()
        sql = "SELECT * FROM ticket_buy_info WHERE p_id = '%s' AND car_no = '%s'" % (p_id, car_no)
        cursor.execute(sql)

        if cursor.rowcount != 0:
            raise Exception("该乘客已购买该车次的票，不能重复购买！")

        sql = "SELECT remain_ticket FROM car_ticket_info WHERE car_no = '%s'" % (car_no)
        cursor.execute(sql)
        c = cursor.fetchall()
        if c[0][0] <= 0:
            raise Exception("余票不足，购票失败！")

        lc_time = time.strftime("%Y%m%d%H%M%S", time.localtime())

        sql = "INSERT INTO ticket_buy_info(p_id, car_no, tk_no, validity, buy_time) VALUES ('%s', '%s', '%s', '%s', %s)" % \
              (p_id, car_no, ticket_no, 2, lc_time)
        cursor.execute(sql)
        print("ok1")

        sql = "UPDATE car_ticket_info SET remain_ticket = remain_ticket - 1 WHERE car_no = '%s'" % (car_no)
        cursor.execute(sql)
        print("ok2")

        sql = "UPDATE passenger_info SET ticket_num = ticket_num + 1, wait_ticket = wait_ticket + 1 WHERE p_id = '%s'" % (p_id)
        cursor.execute(sql)
        print("购买成功")
        conn.commit()
    except Exception as e:
        print(e)
        if f != -2:
            conn.rollback()
        flag = -1
        info = str(e)
    finally:
        if f != -2:
            cursor.close()
            conn.close()
        print(flag)
        return flag, info

def alter_ticket(p_id, name, old_car_no, new_car_no, old_ticket_no, new_ticket_no):
    """
    改签
    :param p_id: 身份证号码
    :param name: 乘客姓名
    :param old_car_no: 原车次号
    :param new_car_no: 改签车次号
    :param old_ticket_no: 原车票单号
    :param new_ticket_no: 改签车票单号
    :return:
    """
    flag = 0
    info = ''
    conn, cursor = connect_db()
    try:
        sql = "SELECT * FROM ticket_buy_info WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        if cursor.rowcount == 0:
            raise Exception("不存在此车票信息")

        # 查看是否已改签过
        sql = "SELECT validity FROM ticket_buy_info WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        i = cursor.fetchall()
        if i[0][0] != 2:
            raise Exception("该车票不能改签")

        # 修改原车票状态
        sql = "UPDATE ticket_buy_info SET validity = 1 WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        print("修改原车票状态ok")

        # 增加改签票信息
        lc_time = time.strftime("%Y%m%d%H%M%S", time.localtime())
        sql = "INSERT INTO alter_ticket_info VALUES ('%s', '%s', '%s', '%s', %s, '%s', %s)" % \
              (p_id, old_ticket_no, new_ticket_no, new_car_no, 0, lc_time, 1)
        cursor.execute(sql)
        print("修改改签信息ok")

        # 修改乘客信息
        sql = "UPDATE passenger_info SET wait_ticket = wait_ticket - 1, alter_ticket = alter_ticket + 1 WHERE p_id = '%s'" % (p_id)
        cursor.execute(sql)
        print("修改乘客信息ok")

        # 修改相应票务信息
        sql = "UPDATE car_ticket_info SET remain_ticket = remain_ticket + 1 WHERE car_no = '%s'" % (old_car_no)
        cursor.execute(sql)
        sql = "UPDATE car_ticket_info SET remain_ticket = remain_ticket - 1 WHERE car_no = '%s'" % (new_car_no)
        cursor.execute(sql)
        print("修改票务信息ok")

        conn.commit()
    except Exception as e:
        print(e)
        conn.rollback()
        flag = -1
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        print(flag)
        return flag, info

def return_ticket(p_id, car_no, old_ticket_no):
    """
    退票
    :param p_id: 身份证号码
    :param car_no: 车次号
    :param old_ticket_no: 原车票号
    :return:
    """
    conn, cursor = connect_db()

    a = old_ticket_no[:2]
    if a == 'GQ':
        sql = "SELECT otk_no FROM alter_ticket_info WHERE atk_no = '%s'" % (old_ticket_no)
        cursor.execute(sql)
        b = cursor.fetchall()
        old_ticket_no = b[0][0]
    """
        p_id varchar(18) NOT NULL
        return_ticket_no varchar(20) NULL
        otk_no varchar(20) NULL原车票编号
        car_no varchar(25) NULL
        return_time datetime NULL
        status tinyint(4) NULL标志
    """
    flag = 0
    info = ''
    try:
        sql = "SELECT * FROM ticket_buy_info WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        if cursor.rowcount == 0:
            raise Exception("不存在此车票信息")

        # 查看是否可以退票
        sql = "SELECT validity FROM ticket_buy_info WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        i = cursor.fetchall()
        if i[0][0] not in [1, 2]:
            raise Exception("该车票不能退票")

        # 修改原车票状态
        sql = "UPDATE ticket_buy_info SET validity = -2 WHERE p_id = '%s' AND tk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        print("修改原车票状态ok")

        sql = "UPDATE alter_ticket_info SET status = -2 WHERE p_id = '%s' AND otk_no = '%s'" % (p_id, old_ticket_no)
        cursor.execute(sql)
        print("修改改签票状态ok")

        # 增加退票信息
        lc_time = time.strftime("%Y%m%d%H%M%S", time.localtime())
        re_no = "TP" + car_no[5:9] + car_no[3:5] + str(random.randint(1000, 9999))
        sql = "INSERT INTO return_ticket_info VALUES ('%s', '%s', '%s', '%s', '%s', %s)" % \
              (p_id, re_no, old_ticket_no, car_no, lc_time, -2)
        cursor.execute(sql)
        print("增加退票信息ok")

        # 修改乘客信息
        sql = "UPDATE passenger_info " \
              "SET wait_ticket = wait_ticket - 1, return_ticket = return_ticket + 1 " \
              "WHERE p_id = '%s'" % (p_id)
        cursor.execute(sql)
        print("修改乘客信息ok")

        # 修改相应票务信息
        sql = "UPDATE car_ticket_info SET remain_ticket = remain_ticket + 1 WHERE car_no = '%s'" % (car_no)
        cursor.execute(sql)
        print("修改票务信息ok")

        conn.commit()
        print("退票成功！")
    except Exception as e:
        print(e)
        conn.rollback()
        flag = -1
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        return flag, info

if __name__ == "__main__":
    # name = input('输入名字:\n')
    # id = input("输入身份证号：\n")
    # car_no = input("输入车次号：\n")
    pass
    # buy_ticket(id, name, '180105005', '123624987')

    # alter_ticket(id, '李四', '180105005', '180105001', '123624987', '932102354')
