//+------------------------------------------------------------------+
//|                                                         vvvv.mq5 |
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
   Derived *d=new Derived;
   Base *pb=(Derived *)d;
   Derived *pd;
   pd=d;
   pd.c();
   pb.f(3.14f);   // Derived::f(float) 3.14  
   pd.f(3.14f);   // Derived::f(float) 3.14  
   pb.g(3.14f);   // Base::g(float)  3.14  
   pd.g(3.14f);   // Derived::g(int) 3.14   
   pb.h(3.14f);   // Base::h(float) 3.14  
   pd.h(3.14f);   // Derived::h(float) 3.14  

  }
//+------------------------------------------------------------------+
class Base
  {
public:
   int               asd;
   virtual void f(float x)
     {
      Print("Base::f(float)",x);
     }
   void g(float x)
     {
      Print("Base::g(float)",x);
     }
   void h(float x)
     {
      Print("Base::h(float)",x);
     }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Derived : public Base
  {
public:

   void c()
     {
      Print(3333);
      Print(asd);
     }
   virtual void f(float x)
     {
      Print("D::f(float)",x);
     }
   void g(int x)
     {
      Print("D::g(float)",x);
     }
   void h(float x)
     {
      Print("D::h(float)",x);
     }
  };
//+------------------------------------------------------------------+
