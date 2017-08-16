//+------------------------------------------------------------------+
//|                                                          ddd.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   int symbol_total=SymbolsTotal(false);
   for(int i_sym_id=0;i_sym_id<symbol_total;i_sym_id++)
     {
      string symbol=SymbolName(i_sym_id,false);
      long spread=SymbolInfoInteger(symbol,SYMBOL_SPREAD);
      double  bid=SymbolInfoDouble(symbol,SYMBOL_BID);
      double per=spread/(bid/SymbolInfoDouble(symbol,SYMBOL_POINT));
      if(per*10000<=3){Print(symbol,per*10000);}
     }

  }
//+------------------------------------------------------------------+
