//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright   "汇狮学院--网址"
#property link        "http://www.gfxa.com"
#property description "统计图表品种在特定时间的点差"
#property strict
#property icon        "\\Images\\icon\\gfxa.ico"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
long max;
long min;
datetime maxtime;
datetime mintime;
double average;
double count;
int    counttimes;
input int X次报价次数统计一次=100;
int i;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   max=0;
   min=100000;
   maxtime=0;
   mintime=0;
   average=0;
   count=0;
   counttimes=0;
   i=0;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   long spread=SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
   if(spread>=max){max=spread;maxtime=TimeCurrent();}
   if(spread<=min){min=spread;mintime=TimeCurrent();}
   count+=double(spread);
   counttimes++;
   if(i%X次报价次数统计一次==0 && i>=X次报价次数统计一次)
     {
      average=count/counttimes;
      Alert("最大点差:",max,"出现时间",maxtime,"最小点差:",min,"出现时间",mintime,"平均点差:",NormalizeDouble(average,2));
     };
   i++;
  }
//+------------------------------------------------------------------+
