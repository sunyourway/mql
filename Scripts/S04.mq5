//+------------------------------------------------------------------+
//|                                                          S04.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include            <..\Experts\sun\Header.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
  S_04 a(8,0.1);
  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  CopyRates(_Symbol,0,0,2000,rates);
  a.Function(rates);
  }
//+------------------------------------------------------------------+
