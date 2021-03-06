//+------------------------------------------------------------------+
//|                                                          pr3.mq5 |
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
string to_split="_life_is_good_"; // 字符串分成子字符串 
string to_split2="_life_is_good_"; // 字符串分成子字符串 
   string sep="_";                // 分隔符为字符 
   ushort u_sep;                  // 分隔符字符代码 
   string result[];               // 获得字符串数组 
   //--- 获得分隔符代码 
   u_sep=StringGetCharacter(sep,0); 
   //--- 字符串分为子字符串 
   int k=StringSplit(to_split,u_sep,result); 
   //--- 显示注释  
   PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep); 
   //--- 现在输出所有获得的字符串 
   if(k>0) 
     { 
      for(int i=0;i<k;i++) 
        { 
         PrintFormat("result[%d]=\"%s\"",i,result[i]); 
        } 
     }
     StringTrimLeft(to_split2);
  }
//+------------------------------------------------------------------+
