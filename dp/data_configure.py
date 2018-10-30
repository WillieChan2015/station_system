#!/usr/bin/env python
# -*- coding:utf-8 -*-

import pymysql
from dp.insert_data import md5

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

def check_account_isExist(user_name):
    """
    检查账户是否存在
    :param user_name:
    :return:
    """
    conn, cursor = connect_db()
    sql = "SELECT * FROM account_info WHERE account = '%s'" % user_name
    print("开始查询%s是否存在" % user_name)
    cursor.execute(sql)

    f = cursor.rowcount

    cursor.close()
    conn.close()
    print(f)
    if f > 0:
        print('已存在')
        return True
    else:
        print('不存在')
        return False

def check_account_level(user_name):
    """
    检查账户级别
    :param user_name:
    :return:
    """
    conn, cursor = connect_db()
    sql = "SELECT id_type FROM account_info WHERE account = '%s'" % user_name
    cursor.execute(sql)
    data = cursor.fetchall()
    cursor.close()
    conn.close()

    return data[0][0]


def account_change_pswd(user_name, new_pswd):
    """
    修改密码
    :param user_name:
    :param new_pswd:
    :return:
    """
    conn, cursor = connect_db()
    flag = 1
    info = ''
    try:
        sql = "UPDATE account_info SET passwd = '%s' WHERE account = '%s'" % (md5(new_pswd), user_name)
        print("开始修改用户名为%s的密码" % user_name)
        cursor.execute(sql)
        info = "修改成功"
        print(info)
        conn.commit()

    except Exception as e:
        print(e)
        conn.rollback()
        flag = 0
        info = str(e)
    finally:
        cursor.close()
        conn.close()
        return info, flag



