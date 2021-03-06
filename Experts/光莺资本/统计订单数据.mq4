//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property  strict
input bool symbolswitch=false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit()
  {
   double tp=0;
   double swap=0;
   double commission=0;
   double countlot=0;
   double s1_lot=0;
   double s2_lot=0;
   int    s1_cnt=0;
   double s1_tp=0;
   double s2_tp=0;
   datetime first_datetime=D'2500.01.01 00:00:00';
   datetime last_datetime=0;
   long holdtime1=0;
   long holdtime2=0;
   double s1_deviation=0;
   int num=0;
   for(int i=0;i<OrdersHistoryTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         if(OrderSymbol()==Symbol() || !symbolswitch)
           {
            if(OrderType()==OP_BUY || OrderType()==OP_SELL)
              {
               tp+=OrderProfit();
               commission+=OrderCommission();
               swap+=OrderSwap();
               countlot+=OrderLots();
               num++;
               datetime order_opentime=OrderOpenTime();
               datetime order_closetime=OrderCloseTime();
               if(order_opentime<first_datetime){first_datetime=order_opentime;}
               if(order_opentime>last_datetime){last_datetime=order_opentime;}
               if(StringFind(OrderComment(),"201701",0)>=0)
                 {
                  s1_cnt++;
                  s1_lot+=OrderLots();
                  s1_tp+=OrderProfit();
                  double deviation=(OrderOpenPrice()-OrderStopLoss())/_Point;
                  s1_deviation+=deviation;
                  holdtime1+=order_closetime-order_opentime;
                 }
               else if(StringFind(OrderComment(),"201702",0)>=0)
                 {
                  s2_lot+=OrderLots();
                  s2_tp+=OrderProfit();
                  holdtime2+=order_closetime-order_opentime;
                 }
              }
           }
        }
     }
   double countlot2=0;
   int num2=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==Symbol() || !symbolswitch)
           {
            if(OrderType()==OP_BUY || OrderType()==OP_SELL)
              {
               countlot2+=OrderLots();
               num2++;
               datetime order_opentime=OrderOpenTime();
               if(order_opentime<first_datetime){first_datetime=order_opentime;}
               if(order_opentime>last_datetime){last_datetime=order_opentime;}
               if(StringFind(OrderComment(),"201701",0)>=0){s1_lot+=OrderLots();s1_tp+=OrderProfit();}
               else if(StringFind(OrderComment(),"201702",0)>=0){s2_lot+=OrderLots();s2_tp+=OrderProfit();}
              }
           }
        }
     }
   double day_between=(last_datetime-first_datetime)/3600/24.0;
   Alert("选定历史周期里盈亏情况(账户基础货币):",NormalizeDouble(tp+commission+swap,2),"总共交易:",NormalizeDouble(countlot,2),"手");
   Alert(num,"单,","手续费:",NormalizeDouble(commission,2),"仓息费:",NormalizeDouble(swap,2));
   Alert("当前持仓交易:",NormalizeDouble(countlot2,2),"手",num2,"单");
   Alert("总共交易:",NormalizeDouble(countlot+countlot2,2),"手",num+num2,"单");
   Alert("相差",NormalizeDouble(day_between,2),"天");
   Alert("s1下单",NormalizeDouble(s1_lot,2),"手");
   Alert("s2下单",NormalizeDouble(s2_lot,2),"手");
   Alert("s1盈利",NormalizeDouble(s1_tp,2));
   Alert("s2盈利",NormalizeDouble(s2_tp,2));
   Alert("s1滑点",s1_deviation,"平均",s1_deviation/s1_cnt,"单",s1_cnt);
   Alert("s1表现值",NormalizeDouble(s1_tp/s1_lot,2));
   Alert("s2表现值",NormalizeDouble(s2_tp/s2_lot,2));
   Alert("日均下单",NormalizeDouble((num+num2)/day_between,2),"月均下单",NormalizeDouble((num+num2)/day_between*30,2));
   Alert("日均手数",NormalizeDouble((countlot+countlot2)/day_between,2),"月均手数",NormalizeDouble((countlot+countlot2)/day_between*30,2));
   Alert("s1持仓秒",holdtime1/s1_cnt);
//Alert("s2持仓秒",holdtime2/s2_cnt);
   ExpertRemove();
  }
//+------------------------------------------------------------------+
void OnTick()
  {
  }
//+---------
