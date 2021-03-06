//+------------------------------------------------------------------+
//|                                                         ISAR.mq4 |
//|                                                       SunRainWay |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
input double sarin=0.0014;
input bool  lotfunction=false;
double sarmax=0.2;
input int mafast= 55;
input int maslow= 90;
int magic=20160916;
datetime timeflag;
input double Lots=0.01;
input double AddLots=0.1;
input double AdcLots=0.1;
extern double MaxLots=1000;
double lot=0;
input string 激活码="";
#include            <..\Experts\sun\Authorization.mqh>
Authorization a(激活码);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
//---
   if(!a.CheckAuthorization()){Alert("验证码无效或过期");ExpertRemove();}
   lot=Lots;
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
   double sar1=iSAR(NULL,0,sarin,sarmax,1);
   double maf1=iMA(NULL,0,mafast,0,MODE_LWMA,PRICE_CLOSE,1);
   double mas1=iMA(NULL,0,maslow,0,MODE_LWMA,PRICE_CLOSE,1);
   double sar2=iSAR(NULL,0,sarin,sarmax,2);
   double maf2=iMA(NULL,0,mafast,0,MODE_LWMA,PRICE_CLOSE,2);
   double mas2=iMA(NULL,0,maslow,0,MODE_LWMA,PRICE_CLOSE,2);
//抛物线上方 快线在慢线下方
   bool upsar1=sar1>High[1];
   bool downma1=maf1<mas1;

   bool upsar2=sar2>High[2];
   bool downma2=maf2<mas2;

   bool downsar1=sar1<High[1];
   bool upma1=maf1>mas1;

   bool downsar2=sar2<High[2];
   bool upma2=maf2>mas2;

   bool firstsell=(upsar1 && downma1) && !(upsar2 && downma2);
   bool firstbuy=(downsar1 && upma1) && !(downsar2 && upma2);
//
   if(lotfunction){ChangeLots();}
//ChangeProfit();

   if(firstsell){OrderSend(NULL,OP_SELL,lot,Bid,30,0,0,NULL,magic);}
   if(firstbuy){OrderSend(NULL,OP_BUY,lot,Ask,30,0,0,NULL,magic);}
   if(((upsar1 && downma1) || (downsar1 && upma1))==false) {CloseOrder("all");}
  }
//+------------------------------------------------------------------+
bool CloseOrder(string cmd)
  {
   bool res=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True && OrderMagicNumber()==magic && OrderSymbol()==Symbol())
        {
         if((cmd=="all" || cmd=="sell") && OrderType()==OP_SELL)
           {
            res=OrderClose(OrderTicket(),OrderLots(),Ask,0,Yellow);
           }
         else if((cmd=="all" || cmd=="buy") && OrderType()==OP_BUY)
           {
            res=OrderClose(OrderTicket(),OrderLots(),Bid,0,Yellow);
           }
         if(!res)
           {
            Print("OrderClose Failed. Error code=",GetLastError());
            res=false;
            break;
           }
        }
     }
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ChangeLots()
  {
   int tag=0;
//lot=Lots;
   for(int i=OrdersHistoryTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true && OrderMagicNumber()==magic && OrderSymbol()==Symbol())
        {
         if(OrderProfit()<0)
           {
            if(tag==-1){break;}
            lot=OrderLots()+AddLots;
            tag=1;
           }
         if(OrderProfit()>0)
           {
            if(tag==1){break;}
            lot=OrderLots()-AdcLots;
            tag=-1;
           }
         if(lot>MaxLots) lot=MaxLots;
         if(lot<MarketInfo(Symbol(),MODE_MINLOT)) lot=MarketInfo(Symbol(),MODE_MINLOT);
         break;
        }
     }
  }
//+------------------------------------------------------------------+
