//+------------------------------------------------------------------+
//|                                                  stringcheck.mq5 |
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
   string a="EURUSD";
   string b="eurusd";
   string c="eurusd.dc";
   string d="EURUSD.o";
   string e="c.eurusd";
   string f="c.EURUSD";
   string g="XAUUSD";
   string h="c.gold";
   string i="XAUUSD.d";
   string j="c.xauusd.dd";

   Print("a",func(a));
   Print("b",func(b));
   Print("c",func(c));
   Print("d",func(d));
   Print("f",func(f));
   Print("g",func(g));
   Print("h",func(h));
   Print("i",func(i));
   Print("j",func(j));
  }
//+------------------------------------------------------------------+
int func(string mysymbol)
  {
   int res=0;
   string symbolarray[10][2]={{"EURUSD"},{"XAUUSD","GOLD"},{"USDJPY"}};
   string symbol=mysymbol;
   StringToUpper(symbol);
   for(int i=0;i<ArrayRange(symbolarray,0);i++)
     {
      for(int j=0;j<2;j++)
        {
         if(StringFind(symbol,symbolarray[i][j],0)>=0)
           {
            res=i+1;
            break;
           }
        }
     }
   if(res==0)
     {
      StringToLower(symbol);
      for(int i=0;i<ArrayRange(symbolarray,0);i++)
        {
         for(int j=0;j<2;j++)
           {
            if(StringFind(symbol,symbolarray[i][j],0)>=0)
              {
               res=i+1;
               break;
              }
           }
        }
     }
   return res;
  }
//+------------------------------------------------------------------+
