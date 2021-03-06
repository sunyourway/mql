void OnStart()
  {
//--- 计数器
   ulong start=GetTickCount();
   ulong now;
   int   count=0;
//--- 用于快速版本维度的数组
   double arr[];
   ArrayResize(arr,100000,100000);
//--- 检查如何加速内存保留工作的变量
   Print("--- Test Fast: ArrayResize(arr,100000,100000)");
   for(int i=1;i<=300000;i++)
     {
      //--- 设置新数组大小指定储备100,000元素！
      ArrayResize(arr,i,100000);
      //--- 当到达整十整百的整数时，显示数组大小和花费的时间
      if(ArraySize(arr)%100000==0)
        {
         now=GetTickCount();
         count++;
         PrintFormat("%d. ArraySize(arr)=%d Time=%d ms",count,ArraySize(arr),(now-start));
         start=now; 
        }
     }
//--- 现在显示，无保留内存的版本有多慢
   double slow[];
   ArrayResize(slow,100000,100000);
//--- 
   count=0;
   start=GetTickCount();
   Print("---- Test Slow: ArrayResize(slow,100000)");
//---
   for(int i=200000;i>=0;i--)
     {
      //--- 设置新的数组大小，但是无额外储备
      ArrayResize(slow,i);
      //--- 当到达整十整百的整数时，显示数组大小和花费的时间
      if(ArraySize(slow)%100000==0)
        {
         now=GetTickCount();
         count++;
         PrintFormat("%d. ArraySize(slow)=%d Time=%d ms",count,ArraySize(slow),(now-start));
         start=now;
        }
     }
  }
