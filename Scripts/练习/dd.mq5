//+------------------------------------------------------------------+
//|                                                           dd.mq5 |
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
   int x=1;
   a(x);
   Print(x);
  }
//+------------------------------------------------------------------+
void a(int &cc)
{
cc=4;
}

//void a(int &cc)
//{
//cc=4;
//}

