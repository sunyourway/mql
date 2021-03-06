//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include            <..\Experts\sun\AuthorizedFree.mqh>
#property script_show_inputs  
input string     input_accountid="4477777"; //需要激活的账号
input datetime input_time=D'2020.01.01';//过期时间                                    
AuthorizedFree authorized();
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   if(TimeCurrent()>=D'2020.06.01')
     {
      Print("生成器过期");
      return;
     }
   string code=authorized.CreateCode(input_accountid,input_time);
   Alert(code);
   authorized.DecryptCode(code);
   Print(datetime(authorized.GetExpiredTime()));
  }
//+------------------------------------------------------------------+
