//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright   "汇狮学院--网址"
#property link        "http://www.gfxa.com"
#property strict
#property show_inputs
#property icon        "\\Images\\icon\\gfxa.ico"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   if(!IsExpertEnabled()){Alert("没有打开智能交易的开关");return;};
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(_Symbol==OrderSymbol())
           {
            if(OrderType()==OP_SELL)
              {
               while(!OrderClose(OrderTicket(),OrderLots(),SymbolInfoDouble(_Symbol,SYMBOL_ASK),30)&&!IsStopped())
                 {
                  Print(GetLastError());
                  Sleep(100);
                 }
              }
            else if(OrderType()==OP_BUY)
              {
               while(!OrderClose(OrderTicket(),OrderLots(),SymbolInfoDouble(_Symbol,SYMBOL_BID),30)&&!IsStopped())
                 {
                  Print(GetLastError());
                  Sleep(100);
                 }
              }
           }
        }
     }
  }
//汇狮学院-孙禕韡
