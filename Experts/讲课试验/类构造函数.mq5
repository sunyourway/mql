//+------------------------------------------------------------------+
//|                                                        class.mq5 |
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
   A *a=new A(10,30);
   B b;
   Print(b.a);
   Print(b.b);
   b.print();
   A *c=new B;
   Print(c.a);
   Print(c.b);
   c.print();
   Print(c.a);
  }
//+------------------------------------------------------------------+
class  A
  {
public:
   int               a;
   int               b;
                     A()
     {
      a=0;
      b=0;
     }
                     A(int mya,int myb)
     {
      a=mya;
      b=myb;
     }
  virtual void  print()
     {
      Print(1111);
     }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class B :public A
  {
public:
                     B():A(40,60)
     {
     }
   void print()
     {
      a=0999;
      Print(2222);
     }
  };
//+------------------------------------------------------------------+
