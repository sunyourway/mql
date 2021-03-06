#property copyright   "汇狮学院--网址"
#property link        "http://www.gfxa.com"
#property description "显示当前品种点差占报价的比例"
#property strict
#property show_inputs
#property icon        "\\Images\\icon\\gfxa.ico"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
  long spread=SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
  double  bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
  Alert("当前点差（小数点最后一位）",spread,"当前卖价",bid);
  double per=spread/(bid/_Point);
  Alert("占万分之",NormalizeDouble(per*10000,2));
  }
//+------------------------------------------------------------------+
