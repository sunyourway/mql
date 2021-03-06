//校验时间2017-04-25
//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#ifndef _LOADHISTORY_H
#define _LOADHISTORY_H
#include "Base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class HistoryData:public Base
  {
public:
                     HistoryData(string param_symbol,ENUM_TIMEFRAMES param_timeframe);
   string            GetPeriodName(ENUM_TIMEFRAMES period);
   void              Download();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
HistoryData::HistoryData(string param_symbol,ENUM_TIMEFRAMES param_timeframe):Base(param_symbol,param_timeframe)
  {
//#ifdef __MQL5__
//   Download();
//#endif
//报价同步
   MqlRates rates[];
   int fail_cnt=0;
   ArraySetAsSeries(rates,true);
   while(!IsStopped())
     {
      if(CopyRates(symbol,timeframe,0,100,rates)==100)
        {
         if(MathAbs(SymbolInfoDouble(symbol,SYMBOL_BID)-rates[0].close)<=rates[0].close*0.0001)
           {
            Print(symbol,GetPeriodName(timeframe),"同步完成");
            break;
           }
         else fail_cnt++;
        }
      else{fail_cnt++;Sleep(100);}
      if(fail_cnt>=20)
        {
         Alert(symbol,GetPeriodName(timeframe),"同步失败");
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string HistoryData::GetPeriodName(ENUM_TIMEFRAMES period=PERIOD_CURRENT)
  {
   switch(period)
     {
      case PERIOD_M1:  return("M1");
      case PERIOD_M2:  return("M2");
      case PERIOD_M3:  return("M3");
      case PERIOD_M4:  return("M4");
      case PERIOD_M5:  return("M5");
      case PERIOD_M6:  return("M6");
      case PERIOD_M10: return("M10");
      case PERIOD_M12: return("M12");
      case PERIOD_M15: return("M15");
      case PERIOD_M20: return("M20");
      case PERIOD_M30: return("M30");
      case PERIOD_H1:  return("H1");
      case PERIOD_H2:  return("H2");
      case PERIOD_H3:  return("H3");
      case PERIOD_H4:  return("H4");
      case PERIOD_H6:  return("H6");
      case PERIOD_H8:  return("H8");
      case PERIOD_H12: return("H12");
      case PERIOD_D1:  return("Daily");
      case PERIOD_W1:  return("Weekly");
      case PERIOD_MN1: return("Monthly");
     }
   return("unknown period");
  }
//void HistoryData::Download()
//  {
//   int fail_cnt=0;
//   while(!(fail_cnt>=1) && !IsStopped())
//     {
//      //int bars_count=SeriesInfoInteger(symbol,timeframe,SERIES_BARS_COUNT);
//      //Print(bars_count);
//      int bars_temp=Bars(symbol,timeframe);
//      //Print(bars_temp);
//      if(bars_temp>=max_bars)
//        {
//         Print(bars_temp,"超过",max_bars,"柱退出");
//         break;
//        }
//      //拷贝之后就已经bars前挪成功的话刷新当前柱数,如果临界请求数据速度会变得超慢所以只检查失败1次
//      int copied=CopyRates(symbol,timeframe,bars_temp,100,times);
//      if(copied>0)
//        {
//         if(show){Print("下载前移至",times[copied-1].time);}
//         fail_cnt=0;
//        }
//      else
//        {
//         fail_cnt++;
//         if(show){Print("下载失败",fail_cnt,"次");}
//         Sleep(100);
//        }
//     }
//   if(show){Print("当前柱数",Bars(symbol,timeframe),"下载完毕");}
//  }
#endif
//+------------------------------------------------------------------+
