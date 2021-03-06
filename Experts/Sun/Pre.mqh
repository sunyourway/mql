//校验时间2017-04-25
//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#ifndef _PRE_H
#define _PRE_H
#include "Base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Pre:public Base
  {
public:
   ENUM_BS           bs;
   bool              tester;
   //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   string            usdjpy;
   string            gbpusd;
   double            tickvalue;
   //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   string            currency_profit;
   double            contract_size;
   double            volumn_min;
   double            volumn_max;
   //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   int               tag_company;
   int               tag_symbol;
   //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   double            spread_control;
   //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                     Pre(string param_symbol="",ENUM_BS param_bs=buysell,double param_spd=0,string param_usdjpy="",string param_gbpusd="");
                    ~Pre(void);
   int               GetTagSymbol(string param_symbol);
   double            GetTickValue();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Pre::Pre(string param_symbol="",ENUM_BS param_bs=buysell,double param_spd=0,string param_usdjpy="",string param_gbpusd=""):Base(param_symbol,0)
  {
   tester=MQLInfoInteger(MQL_TESTER);
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   currency_profit=SymbolInfoString(symbol,SYMBOL_CURRENCY_PROFIT);
   contract_size=SymbolInfoDouble(symbol,SYMBOL_TRADE_CONTRACT_SIZE);
   volumn_min=SymbolInfoDouble(symbol,SYMBOL_VOLUME_MIN);
   volumn_max=SymbolInfoDouble(symbol,SYMBOL_VOLUME_MAX);
   tag_symbol=GetTagSymbol(param_symbol);
   bs=param_bs;
   spread_control=param_spd;
   usdjpy=param_usdjpy;
   gbpusd=param_gbpusd;
   tickvalue=GetTickValue();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Pre::~Pre(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Pre::GetTagSymbol(string param_symbol)
  {
   int res=0;
   string symbol_short[SYMBOL_SIZE][2];
   symbol_short[XAUUSD][0]="XAUUSD";
   symbol_short[XAUUSD][1]="GOLD";
   symbol_short[EURUSD][0]="EURUSD";
   symbol_short[USDJPY][0]="USDJPY";
   symbol_short[GBPUSD][0]="GBPUSD";
   symbol_short[EURJPY][0]="EURJPY";
   symbol_short[EURGBP][0]="EURGBP";
   symbol_short[GBPJPY][0]="GBPJPY";
   symbol_short[USDCHF][0]="USDCHF";
   symbol_short[USDCNH][0]="USDCNH";
   symbol_short[USDCAD][0]="USDCAD";
   symbol_short[AUDUSD][0]="AUDUSD";
   string symbol_full=param_symbol;
   StringToUpper(symbol_full);
   int symbol_short_size=ArrayRange(symbol_short,0);
   for(int i=0;i<symbol_short_size;i++)
     {
      for(int j=0;j<2;j++)
        {
         if(StringFind(symbol_full,symbol_short[i][j],0)>=0)
           {
            res=i;
            return res;
           }
        }
     }
   if(res==0){Print("非指定品种");}
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Pre::GetTickValue()
  {
   double res=0;
   switch(tag_symbol)
     {
      case XAUUSD:  return contract_size*point;
      case EURUSD:  return contract_size*point;
      case USDJPY:
        {
         double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
         double price=bid!=0?bid:100;
         return contract_size*point/price;
        }
      case GBPUSD:  return contract_size*point;
      case EURJPY:
        {
         if(tester){return SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);}
         double bid=SymbolInfoDouble(usdjpy,SYMBOL_BID);
         double price=bid!=0?bid:100;
         return contract_size*point/price;
        }
      case EURGBP:
        {
         if(tester){return SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);}
         double bid=SymbolInfoDouble(gbpusd,SYMBOL_BID);
         double price=bid!=0?bid:1.28;
         return contract_size*point*price;
        }
      case GBPJPY:
        {
         if(tester){return SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);}
         double bid=SymbolInfoDouble(usdjpy,SYMBOL_BID);
         double price=bid!=0?bid:100;
         return contract_size*point/price;
        }
      case USDCHF:
        {
         double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
         double price=bid!=0?bid:1;
         return contract_size*point/price;
        }
      case USDCNH:
        {
         double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
         double price=bid!=0?bid:6.8;
         return contract_size*point/price;
        }
      case USDCAD:
        {
         double bid=SymbolInfoDouble(symbol,SYMBOL_BID);
         double price=bid!=0?bid:1.3;
         return contract_size*point/price;
        }
      case AUDUSD:  return contract_size*point;
      default:
         res=SymbolInfoDouble(symbol,SYMBOL_TRADE_TICK_VALUE);
         break;
     }
   return res;
  }
#endif 
//+------------------------------------------------------------------+
