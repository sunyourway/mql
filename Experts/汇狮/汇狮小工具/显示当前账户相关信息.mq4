//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright   "汇狮学院--网址"
#property description "请在终端-EA栏里查看信息"
#property link        "http://www.gfxa.com"
#property strict
#property show_inputs
#property icon        "\\Images\\icon\\gfxa.ico"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   printf("挂单上限 = %d",AccountInfoInteger(ACCOUNT_LIMIT_ORDERS));
//--- 显示AccountInfoInteger()函数中所有有效信息 
   printf("账户杠杆 =  %d",AccountInfoInteger(ACCOUNT_LEVERAGE));
   bool EATradeAllowed=AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
   ENUM_ACCOUNT_STOPOUT_MODE stopOutMode=(ENUM_ACCOUNT_STOPOUT_MODE)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);
//--- 找出是否可能通过EA交易进行这个账户的交易 
   if(EATradeAllowed)
      Print("允许ea交易");
   else
      Print("不允许ea交易");
//--- 找出止损离场水平设置模式 
   switch(stopOutMode)
     {
      case(ACCOUNT_STOPOUT_MODE_PERCENT):
         Print("用百分比计算强制平仓");
         break;
      default:Print("用货币计算强制平仓");
     }
   printf("强制平仓水平线 = %G",AccountInfoDouble(ACCOUNT_MARGIN_SO_SO));
   Print("服务器名称 = ",AccountInfoString(ACCOUNT_SERVER));

  }
//+------------------------------------------------------------------+
