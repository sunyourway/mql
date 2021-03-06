//校验时间2017-04-25
//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#ifndef _MONITOR_H
#define _MONITOR_H
#include "Base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Monitor:public Base
  {
public:
   struct             Monitor_Struct
     {
      double            price;
      double            lot;
      datetime          time;
      bool              cross;
      bool              finish;
      double            above_price;
      double            below_price;
     };
   Monitor_Struct    lower[];
   Monitor_Struct    upper[];
                     Monitor(string param_symbol);
                    ~Monitor();
   void              ResizeInitial(int param_lower_size,int param_upper_size);
   void              Initial(Monitor_Struct &param_class[]);
   void              Cross(bool param_show=true);//突破
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Monitor::Monitor(string param_symbol):Base(param_symbol)
  {
   ResizeInitial(3,3);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Monitor::~Monitor(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+ 
void Monitor::ResizeInitial(int param_lower_size,int param_upper_size)
  {
   ArrayResize(lower,param_lower_size);
   ArrayResize(upper,param_upper_size);
   Initial(upper);
   Initial(lower);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Monitor::Initial(Monitor_Struct &param_class[])
  {
   int param_class_size=ArrayRange(param_class,0);
   for(int i=0;i<param_class_size;i++)
     {
      param_class[i].price=0;
      param_class[i].lot=0;
      param_class[i].time=0;
      param_class[i].cross=false;
      param_class[i].finish=false;
      param_class[i].above_price=0;
      param_class[i].below_price=0;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Monitor::Cross(bool param_show=true)
  {
   double price=Price();
   int lower_size=ArrayRange(lower,0);
   for(int i=0;i<lower_size;i++)
     {
      if(lower[i].cross==false)
        {
         if(price<lower[i].price)
           {
            lower[i].time=Time();
            lower[i].cross=true;
            if(param_show)
              {
               Print(symbol,"图表下方价格:",lower[i].price);
               Print(symbol,"首次突破报价:",price);
               Print(symbol,"首次突破时间:",lower[i].time);
               Print(symbol,"首次突破点差:",Spread());
              }
           }
        }
     }
//***********************************************************************************************************************************************************************************    
   int upper_size=ArrayRange(upper,0);
   for(int i=0;i<upper_size;i++)
     {
      if(upper[i].cross==false)
        {
         if(upper[i].price!=0 && price>upper[i].price)//并且买入不能为0
           {
            upper[i].time=Time();
            upper[i].cross=true;
            if(param_show)
              {
               Print(symbol,"图表上方价格:",upper[i].price);
               Print(symbol,"首次突破报价:",price);
               Print(symbol,"首次突破时间:",upper[i].time);
               Print(symbol,"首次突破点差:",Spread());
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
#endif 
//+------------------------------------------------------------------+
