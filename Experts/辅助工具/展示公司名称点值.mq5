//+------------------------------------------------------------------+
//|                                                          cpy.mq5 |
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
   Print(AccountInfoString(ACCOUNT_COMPANY));
   Print(SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE));
   Print(SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE));
  }
//+------------------------------------------------------------------+
