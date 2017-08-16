//+------------------------------------------------------------------+
//|                                                         dpdl.mq5 |
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
   MathSrand(GetTickCount()); 
   for(int i=rand()%2;i<4;i++)
     {
      Print("i",i);
      //for(int j=i+1;j<5;j++)
      //{
      //Print("j",j);
      //}
     }
  }
//+------------------------------------------------------------------+
