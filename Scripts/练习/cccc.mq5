//+------------------------------------------------------------------+
//|                                                         cccc.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
  int a[2][2]={{1,2},{3,4}};
  int b[][2];
  ArrayCopy(b,a);
  ArrayPrint(b);
  
  v(b);
  }
//+------------------------------------------------------------------+
void v(int &p[][2])
{
ArrayPrint(p);

}