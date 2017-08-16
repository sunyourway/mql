//+------------------------------------------------------------------+
//|                                                          ccc.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include            <..\Experts\sun\Order.mqh>
datetime f;
input int fma=5;
input int sma=10;
input double gap=0.5;
double ma1_arr[];
double ma2_arr[];
MqlRates rates[];
double pr=0;
Order *order;
OrderManage *ms;
bool uc=false;
bool dc=false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ArraySetAsSeries(ma1_arr,true);
   ArraySetAsSeries(ma2_arr,true);
   ArraySetAsSeries(rates,true);
   order=new Order(_Symbol,1133);
   ms=new OrderManage(false,1133,0,0,0,0,0,0);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
  delete order;
  delete ms;
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CopyRates(NULL,0,0,5,rates);
   if(f!=rates[1].time)
     {
      f=rates[1].time;
      //Print(1);
      pr=0;
      int ma1=iMA(NULL,0,fma,0,MODE_SMA,PRICE_CLOSE);
      int ma2=iMA(NULL,0,sma,0,MODE_SMA,PRICE_CLOSE);
      CopyBuffer(ma1,0,0,5,ma1_arr);
      CopyBuffer(ma2,0,0,5,ma2_arr);
      uc=ma1_arr[1]>ma2_arr[1]&&ma1_arr[2]<ma2_arr[2];
      dc=ma1_arr[1]<ma2_arr[1]&&ma1_arr[2]>ma2_arr[2];
      order.LotsOptimized();
      if(uc){ms.CloseOrder(sell);Print("uc");}
      if(dc||rates[1].close<ma1_arr[1]){ms.CloseOrder(buy);}
      if(uc && rates[1].low-ma1_arr[1]<=gap)
        {
         pr=rates[1].close;
        }
     }
   if(uc&&rates[1].low>ma1_arr[1])
     {
      if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<pr)
        {
         order.SendOrder(buy);
         uc=false;
        }
     }
  }

//+------------------------------------------------------------------+
