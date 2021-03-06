//汇狮学院-孙禕韡
#property copyright "汇狮学院-网址"
#property link      "https://www.gfxa.com"
#property version   "1.00"
#property icon        "\\Images\\icon\\gfxa.ico"
#property strict
#property description "计算当前图表的交易品种的所有手动交易订单的盈亏的和，包含仓息费和交易佣金"
#property description "如果该值大于输入参数~盈利金额~，全部市价平仓"
#property description "保本平仓，短线剥头皮和刷单利器，实际成交价格可能产生偏移"
input double 盈利金额=0.2;
input int    魔术号码=0;
input bool   使用魔术号码=true;
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
   CloseWhenProfit(盈利金额);
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
void CloseWhenProfit(double profit=0)
  {
   double totalprofit=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
        {
         if(OrderSymbol()==_Symbol)
            if(OrderMagicNumber()==魔术号码 || !使用魔术号码)
              {
                 {
                  totalprofit+=OrderProfit()+OrderCommission()+OrderSwap();//累加求和
                 }
              }
        }
     }
   if(totalprofit>=profit)
     {
      CloseOrder("all");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CloseOrder(string cmd)
  {
   bool res=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
        {
         if(OrderSymbol()==_Symbol)
           {
            if(OrderMagicNumber()==魔术号码 || !使用魔术号码)
              {
               if((cmd=="all" || cmd=="sell") && OrderType()==OP_SELL)
                 {
                  res=OrderClose(OrderTicket(),OrderLots(),MarketInfo(_Symbol,MODE_ASK),3,Yellow);
                 }
               else if((cmd=="all" || cmd=="buy") && OrderType()==OP_BUY)
                 {
                  res=OrderClose(OrderTicket(),OrderLots(),MarketInfo(_Symbol,MODE_BID),3,Yellow);
                 }
              }
           }
         if(!res)
           {
            Print("OrderClose Failed. Error code=",GetLastError());
           }
        }
     }
   return res;
  }
//汇狮学院-孙禕韡
