//+------------------------------------------------------------------+
//|                                                    MySQL-003.mq5 |
//|                                   Copyright 2014, Eugene Lugovoy |
//|                                              http://www.mql5.com |
//| Inserting data with multi-statement (DEMO)                       |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Eugene Lugovoy."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <MQLMySQL.mqh>

string INI;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   string Host,User,Password,Database,Socket; // database credentials
   int Port,ClientFlag;
   int DB; // database identifier

   Print(MySqlVersion());

   INI=TerminalInfoString(TERMINAL_PATH)+"\\MQL5\\Scripts\\MyConnection.ini";

// reading database credentials from INI file
   Host = ReadIni(INI, "MYSQL", "Host");
   User = ReadIni(INI, "MYSQL", "User");
   Password = ReadIni(INI, "MYSQL", "Password");
   Database = ReadIni(INI, "MYSQL", "Database");
   Port     = (int)StringToInteger(ReadIni(INI, "MYSQL", "Port"));
   Socket   = ReadIni(INI, "MYSQL", "Socket");
   ClientFlag=CLIENT_MULTI_STATEMENTS; //(int)StringToInteger(ReadIni(INI, "MYSQL", "ClientFlag"));  

   Print("Host: ",Host,", User: ",User,", Database: ",Database);

// open database connection
   Print("Connecting...");

   DB=MySqlConnect(Host,User,Password,Database,Port,Socket,ClientFlag);

   if(DB==-1) { Print("Connection failed! Error: "+MySqlErrorDescription); } else { Print("Connected! DBID#",DB);}

// Inserting data 1 row
   MqlRates a[];
   CopyRates(NULL,0,1,1000,a);
   string Query;
   for(int i=0;i<100;i++)
     {
      for(int j=i*10;j<10;j++)
        {
         Query+="INSERT INTO `symbol` (time,open, high, low, close) VALUES ("+"\'"+TimeToString(a[i].time,TIME_DATE|TIME_SECONDS)+"\',"+a[i].open+","+a[i].high+","+a[i].low+","+a[i].close+");";
        }
      if(MySqlExecute(DB,Query))
        {
         Print("Succeeded: ",Query);
        }
      else
        {
         Print("Error: ",MySqlErrorDescription);
         Print("Query: ",Query);
        }
     }
   MySqlDisconnect(DB);
   Print("Disconnected. Script done!");
  }
//+------------------------------------------------------------------+
