#include  "Chart.mqh"
class Array
  {
public:
                     Array();
                    ~Array();
   double            CalHighest(double &array[]);
   double            CalLowest(double &array[]);
   double            CalSum(double &array[]);
   double            CalAverage(double &array[]);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Array::Array(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  Array::CalHighest(double &array[])
  {
   double res=0;
   double temp=0;
   for(int i=0;i<ArrayRange(array,0);i++)
     {
      if(array[i]==0){break;}
      if(array[i]>temp)
        {
         temp=array[i];
        }
     }
   res=temp;
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  Array::CalLowest(double &array[])
  {
   double res=0;
   double temp=array[0];
   for(int i=0;i<ArrayRange(array,0);i++)
     {
      if(array[i]==0){break;}
      if(array[i]<temp)
        {
         temp=array[i];
        }
     }
   res=temp;
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  Array::CalSum(double &array[])
  {
   double res=0;
   double sum=0;
   for(int i=0;i<ArrayRange(array,0);i++)
     {
      sum+=array[i];
     }
   res=sum;
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Array::CalAverage(double &array[])
  {
   double res=0;
   double sum=0;
   int elements=ArrayRange(array,0);
   for(int i=0;i<elements;i++)
     {
      sum+=array[i];
     }
   res=sum/elements;
   return res;
  }
//+------------------------------------------------------------------+
