#!/usr/bin/env python
# -*- coding:utf-8 -*-

import pymysql

def connect_db() -> object:
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

def test_insert():
    conn = pymysql.connect(host='127.0.0.1',
                           port=3306,
                           user='user1',
                           passwd='',
                           db='station_system',
                           charset='utf8')

    cursor = conn.cursor()

    try:
        sql = "insert into `car_info` value (%s, '%s', '%s', '%s', %s, %s, %s)" % ('180104001', '粤A-0300', '广州', '深圳', '20180104060000', '013000', 38)
        # sql = "select * from `car_info`"
        print(sql)
        cursor.execute(sql)

        # for r in cursor.fetchall():
        #     print(r)
        print("Done!")
        conn.commit()
    except Exception as e:
        print("ERROR!")
        print(e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

conn, cursor = connect_db()
try:
    # sql = "SELECT validity FROM ticket_buy_info WHERE p_id = '%s' AND tk_no = '%s'" % ('430125199206051230', '123624987')
    sql = "SELECT id_type FROM account_info WHERE account = '%s' AND passwd = '%s'" % ('user1', '123456')
    cursor.execute(sql)

    i = cursor.fetchall()
    print(i)
    print(type(i[0][0]))
except Exception as e:
    print(e)
finally:
    cursor.close()
    conn.close()
