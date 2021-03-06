//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#define  LIMIT 30
#include <MQLMySQL.mqh>
enum DATABASE{metaquotes=0,apari=1,xm=2};
input string host="localhost";
input string user="root";
input string password="1234";
//input DATABASE database=metaquotes;
int DB[];
string db_name[];
int size=3;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct A
  {
   int               id;
   datetime          time_local;
   double            mid;
   datetime          time_sever;
   double            bid;
   double            ask;
   //double            spread;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   EventSetMillisecondTimer(100);
   ArrayResize(DB,size);
   ArrayResize(db_name,size);
   db_name[metaquotes]="metaquotes";
   db_name[apari]="apari";
   db_name[xm]="xm";
//*********************************************************************************************************************************************************************************** 
   Print(MySqlVersion());
   Print("Connecting...");
//*********************************************************************************************************************************************************************************** 
   for(int i=0;i<size;i++)
     {
      DB[i]=MySqlConnect(host,user,password,db_name[i],3306,"0",CLIENT_MULTI_STATEMENTS);
      if(DB[i]==-1) { Print("Connection failed! Error: "+MySqlErrorDescription); } else { Print("Connected! DBID#",DB[i]);}
     }
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   EventKillTimer();
   for(int i=0;i<size;i++)
     {
      MySqlDisconnect(DB[i]);
     }
   Print("Disconnected. Script done!");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
   ulong t1=GetMicrosecondCount();
   string Query="SELECT id,time_local,mid,time_sever,bid,ask FROM `eurusd_tick` ORDER BY id DESC LIMIT 30";
//*********************************************************************************************************************************************************************************** 
   A a[][LIMIT];
   ArrayResize(a,size);
   ZeroMemory(a);
   for(int i=0;i<size;i++)
     {
      int Cursor=MySqlCursorOpen(DB[i],Query);
      if(Cursor>=0)
        {
         int Rows=MySqlCursorRows(Cursor);
         //Print(Rows," row(s) selected.");
         for(int j=0; j<Rows; j++)
           {
            if(MySqlCursorFetchRow(Cursor))
              {
               a[i][j].id=MySqlGetFieldAsInt(Cursor,0);
               a[i][j].time_local=MySqlGetFieldAsDatetime(Cursor,1);
               a[i][j].mid=MySqlGetFieldAsDouble(Cursor,2);
               a[i][j].time_sever=MySqlGetFieldAsDatetime(Cursor,3);
               a[i][j].bid=MySqlGetFieldAsDouble(Cursor,4);
               a[i][j].ask=MySqlGetFieldAsDouble(Cursor,5);
              }
           }
         MySqlCursorClose(Cursor); // NEVER FORGET TO CLOSE Cursor !!!
        }
      else
        {
         Print("Cursor opening failed. Error: ",MySqlErrorDescription);
        }
     }
//*********************************************************************************************************************************************************************************** 
   double lowest_ask=1000000;
   int    lowest_ask_id=-1;
   double highest_bid=0;
   int    highest_bid_id=-1;
   for(int i=0;i<size;i++)
     {
      if(a[i][0].ask<lowest_ask)
        {
         lowest_ask=a[i][0].ask;
         lowest_ask_id=i;
        }
      if(a[i][0].bid>highest_bid)
        {
         highest_bid=a[i][0].bid;
         highest_bid_id=i;
        }
     }
   double gap=NormalizeDouble(highest_bid-lowest_ask,_Digits);

//PrintFormat("%."+string(_Digits)+"f",gap);
   if(gap>0.00000)
     {
      if(lowest_ask_id!=0 || highest_bid_id!=0){Print("lowest_ask",lowest_ask_id,"highest_bid",highest_bid_id);}
      Print("lowest_ask_id",lowest_ask_id,"highest_bid_id",highest_bid_id);
      PrintFormat("%."+string(_Digits)+"f",gap);
     }
   for(int i=0;i<size;i++)
     {
      for(int j=0;j<LIMIT;j++)
        {

        }
     }
//*********************************************************************************************************************************************************************************** 
//ArrayPrint(a);
   bool a_ask_low=true;
   bool b_ask_low=true;
//for(int i=0;i<30;i++)
//  {
//   double dif_a_ask_low=NormalizeDouble(b[i].bid-a[i].ask,_Digits);
//   double dif_b_ask_low=NormalizeDouble(a[i].bid-b[i].ask,_Digits);
//   //long time_gap=a[i].time_local-b[i].time_local;
//   //Print(dif,":",time_gap);
//   //Print(a[metaquotes].time_sever);
//   //Print(b[metaquotes].time_sever);
//   if(dif_a_ask_low>=0.00015){Print("dif_a_ask_low",dif_a_ask_low);}
//   if(dif_b_ask_low>=0.00015){Print("dif_b_ask_low",dif_b_ask_low);}
//   //if(MathAbs(dif)<=0.00010)
//   //  {
//   //   a_g=false;
//   //  }
//  }

//if(a_g)
//  {
//   Print(db_name[metaquotes],a[metaquotes].mid);
//   Print(db_name[apari],b[metaquotes].mid);
//   Print(NormalizeDouble(a[metaquotes].mid-b[metaquotes].mid,_Digits+1));
//  }
//Print((GetMicrosecondCount()-t1)/1000000.0,"seconds"); //0.001
  }
//+------------------------------------------------------------------+
