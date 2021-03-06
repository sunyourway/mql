//+------------------------------------------------------------------+
//|                                                         均线工具.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
enum  type{buy=1,sell=2};
input type openmode=buy;//开仓模式
input double lot=0.01;//手数
input int addmaperiod=30;//加仓均线
input int endmaperiod=72;//终止均线
input ENUM_MA_METHOD mamode=MODE_SMA;//均线模式
input int gap=200;
datetime timeflag=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(timeflag==Time[1]){return;}
   timeflag=Time[1];
   double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
   double endma=iMA(NULL,0,endmaperiod,0,mamode,PRICE_CLOSE,1);
   double addma1=iMA(NULL,0,addmaperiod,0,mamode,PRICE_CLOSE,1);
   double addma2=iMA(NULL,0,addmaperiod,0,mamode,PRICE_CLOSE,2);
   double addma3=iMA(NULL,0,addmaperiod,0,mamode,PRICE_CLOSE,3);
   double addma4=iMA(NULL,0,addmaperiod,0,mamode,PRICE_CLOSE,4);
   if(openmode==buy)
     {
      bool frontup=Close[4]>=addma4 && Close[3]>=addma3 && Close[2]>=addma2;
      bool frontupstr=Close[4]-addma4>=gap*_Point || Close[3]-addma3>=gap*_Point || Close[2]-addma2>=gap*_Point;
      if(frontup && frontupstr && Close[1]<addma1 && Close[1]>endma)
        {
         while(!OrderSend(_Symbol,OP_BUY,lot,SymbolInfoDouble(_Symbol,SYMBOL_ASK),3,0,0,IntegerToString(7788),7788) && !IsStopped())
           {
            Print(GetLastError());
           }
        }
      if(bid<endma)
        {
         CloseOrder("all",7788);
        }
     }
   if(openmode==sell)
     {
      bool frontdown=Close[4]<=addma4 && Close[3]<=addma3 && Close[2]<=addma2;
      bool frontdownstr=addma4-Close[4]>=gap*_Point || addma3-Close[3]>=gap*_Point || addma2-Close[2]>=gap*_Point;
      if(frontdown && frontdownstr && Close[1]>addma1 && Close[1]<endma)
        {
         while(!OrderSend(_Symbol,OP_SELL,lot,SymbolInfoDouble(_Symbol,SYMBOL_BID),3,0,0,IntegerToString(7788),7788) && !IsStopped())
           {
            Print(GetLastError());
           }
        }
      if(bid>endma)
        {
         CloseOrder("all",7788);
        }
     }
  }
//+------------------------------------------------------------------+
void CloseOrder(string cmd,int magicnumber)
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True && OrderMagicNumber()==magicnumber && OrderSymbol()==_Symbol)
        {
         if((cmd=="all" || cmd=="sell") && OrderType()==OP_SELL)
           {
            while(!OrderClose(OrderTicket(),OrderLots(),SymbolInfoDouble(_Symbol,SYMBOL_ASK),0,Yellow) && !IsStopped())
              {
               Print(GetLastError());
              }
           }
         else if((cmd=="all" || cmd=="buy") && OrderType()==OP_BUY)
           {
            while(!OrderClose(OrderTicket(),OrderLots(),SymbolInfoDouble(_Symbol,SYMBOL_BID),0,Yellow) && !IsStopped())
              {
               Print(GetLastError());
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
