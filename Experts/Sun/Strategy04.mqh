//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#ifndef _S_04_H
#define _S_04_H
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class S_04
  {
public:
   bool              pre;
   int               period;
   double            x;
   //***********************************************************************************************************************************************************************************
   long              period_time;
   double            delta_d[];
   double            delta_ratio[];
   long              delta_t[];
   //***********************************************************************************************************************************************************************************
   struct            S_04_Line
     {
      double            price;
      int               period;
      double            x;
     };
   S_04_Line         upper[];
   S_04_Line         lower[];
                     S_04(int param_period,double param_x);
                    ~S_04(void);
   void              Initial(S_04_Line &param_line[]);
   void              Function(const MqlRates &param_rates[]);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
S_04::S_04(int param_period,double param_x)
  {
   period=param_period;
   x=param_x;
   ArrayResize(delta_d,period);
   ArrayResize(delta_ratio,period);
   ArrayResize(delta_t,period);
   ArrayResize(upper,period);
   ArrayResize(lower,period);
   Initial(upper);
   Initial(lower);
   period_time=period*350;
   pre=period<=0 || x<=0?false:true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
S_04::~S_04(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
S_04::Initial(S_04_Line &param_line[])
  {
   for(int i=0;i<period;i++)
     {
      param_line[i].price=0;
      param_line[i].period=0;
      param_line[i].x=0;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void S_04::Function(const MqlRates &param_rates[])
  {
   Initial(upper);
   Initial(lower);
   const int param_rates_size=ArraySize(param_rates);
   pre=param_rates_size-1-2*period<=0?false:pre;
   if(!pre){Print(param_rates[0].close,"S_04_Function does not work");return;}
//*********************************************************************************************************************************************************************************** 
   ArrayInitialize(delta_d,0);
   ArrayInitialize(delta_ratio,0);
   ArrayInitialize(delta_t,0);
   for(int i=0;i<period;i++)
     {
      int j_start=i+1;
      int j_end=j_start+period;
      for(int j=j_start;j<j_end;j++)
        {
         delta_d[i]+=param_rates[j].close-param_rates[j+1].close;
         delta_t[i]+=long(param_rates[j].time-param_rates[j+1].time);
        }
      delta_ratio[i]=delta_d[i]/param_rates[i+1].close;
     }
//*********************************************************************************************************************************************************************************** 
   for(int i=0;i<period;i++)
     {
      if(i==0)
        {
         if(delta_ratio[i]>=x && delta_t[i]<period_time)
           {
            upper[i].price=param_rates[i+1].close;
            upper[i].period=period;
            upper[i].x=delta_ratio[i];
           }
         else{break;}
        }
      else if(delta_ratio[i]>=x)
        {
         Initial(upper);
         break;
        }
     }
//*********************************************************************************************************************************************************************************** 
   for(int i=0;i<period;i++)
     {
      if(i==0)
        {
         if(delta_ratio[i]<=-x && delta_t[i]<period_time)
           {
            lower[i].price=param_rates[i+1].close;
            lower[i].period=period;
            lower[i].x=delta_ratio[i];
           }
         else{break;}
        }
      else if(delta_ratio[i]<=-x)
        {
         Initial(lower);
         break;
        }
     }
//ArrayPrint(delta_d);
//ArrayPrint(delta_ratio);
//ArrayPrint(upper);
//ArrayPrint(lower);
  }
#endif 
//+------------------------------------------------------------------+
