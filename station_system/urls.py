"""station_system URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
# from django.contrib import admin
from dp import views
from django.views.generic.base import RedirectView

urlpatterns = [
    # url(r'^admin/', admin.site.urls),
    url(r'^$', views.home, name='home'),
    url(r'^login/', views.login, name='login'),
    # url(r'^index/', views.index, name='index'),
    # url(r'^index2/', views.index2, name='index2'),
    url(r'^check_ticket/', views.check_ticket, name='check_ticket'),
    url(r'^check_re_al_pa_info/', views.check_re_al_pa_info, name='check_re_al_pa_info'),
    url(r'^check_all_pa_ti/', views.check_all_pa_ti, name='check_all_pa_ti'),
    url(r'^buy_ticket/', views.buy_ticket, name='buy_ticket'),
    url(r'^alter_ticket/', views.alter_ticket, name='alter_ticket'),
    url(r'^return_ticket/', views.return_ticket, name='return_ticket'),
    url(r'^del_all_car/', views.del_all_car, name='del_all_car'),
    url(r'^insert_many_car/', views.insert_many_car, name='insert_many_car'),
    url(r'^del_one_car/', views.del_one_car, name='del_one_car'),
    url(r'^insert_one_car/', views.insert_one_car, name='insert_one_car'),
    url(r'^check_account_info/', views.check_account_info, name='check_account_info'),
    url(r'^change_account_password/', views.change_account_password, name='change_account_password'),
    url(r'^account_delete/', views.account_delete, name='account_delete'),
    url(r'^check_account_isExist/', views.check_account_isExist, name='check_account_isExist'),
    url(r'^create_account/', views.create_account, name='create_account'),


    url(r'^favicon\.ico$', RedirectView.as_view(url=r'static/images/favicon.ico')),
    url(r'^\S+/*$', views.redirect_home, name='redirect_home'),

]
