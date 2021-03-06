//校验时间2017-06-08
//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#ifndef _AUTHORIZED_H
#define _AUTHORIZED_H
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Authorized
  {
private:
   string            key;
   string            key2;
   bool              authorized;
   long              account_id;
   long              decrypt_account_id;
   datetime          decrypt_expired_time;
public:
                     Authorized();
                    ~Authorized();
   string            CreateCode(string param_account_id,datetime param_expired_time);
   void              DecryptCode(string param_code);
   string            Encode(string srcstr,string key_string);
   string            Decode(string srcstr,string key_string);
   string            CharArraytoStringText(uchar &arr[]);
   void              StringTexttoCharArray(string stringtext,uchar &arr[]);
   bool              CheckAuthorized();
   datetime          GetExpiredTime();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Authorized::Authorized()
  {
   key="SUNWAY";
   key2="ABCDEF";
   authorized=false;
   account_id=AccountInfoInteger(ACCOUNT_LOGIN);
   decrypt_account_id=0;
   decrypt_expired_time=0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Authorized::~Authorized()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Authorized::CreateCode(string param_account_id,datetime param_expired_time)
  {
   string res="";
   string account_code=Encode(param_account_id,key);
   string time_code_1=Encode(TimeToString(param_expired_time),key);
   string time_code_2=Encode(TimeToString(param_expired_time),key2);
   res=account_code+"a"+time_code_1+"t"+time_code_2;
   return res;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Authorized::DecryptCode(string param_code)
  {
   int apos=StringFind(param_code,"a");
   int tpos=StringFind(param_code,"t");
   string account_id_code=StringSubstr(param_code,0,apos);
   string time_code_1=StringSubstr(param_code,apos+1,tpos-apos-1);
   string time_code_2=StringSubstr(param_code,tpos+1,StringLen(param_code)-1-tpos);
   string decrypt_account_id_temp=Decode(account_id_code,key);
   string decrypt_time_1=Decode(time_code_1,key);
   string decrypt_time_2=Decode(time_code_2,key2);
   decrypt_account_id=StringToInteger(decrypt_account_id_temp);
   if(decrypt_time_1==decrypt_time_2){decrypt_expired_time=StringToTime(decrypt_time_1);}
//Print(decrypt_account_id);
//Print(decrypt_expired_time);
   if(account_id==decrypt_account_id && decrypt_expired_time!=0)
     {
      authorized=true;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Authorized::CheckAuthorized(void)
  {
   return authorized;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Authorized::GetExpiredTime(void)
  {
   return decrypt_expired_time;
  }
//+------------------------------------------------------------------+
string Authorized::Encode(string srcstr,string key_arr_string)
  {
   uchar src[],key_arr[],dst[];
//--- 准备密钥 
   StringToCharArray(key_arr_string,key_arr);
//--- 复制文本到源数组src[] 
   StringToCharArray(srcstr,src);
//--- 打印初始数据 
//PrintFormat("Initial data: size=%d, string='%s'",ArraySize(src),CharArrayToString(src));
//--- 用key_arr[]的DES56位密钥加密DES src[] 
   int res=CryptEncode(CRYPT_DES,src,key_arr,dst);
//Print("key_arrword");
//ArrayPrint(key_arrword);
//Print("dedst");
//ArrayPrint(dst);
   if(res>0)
     {
      //--- 打印加密数据 
      //PrintFormat("Encoded data: size=%d %s",res,CharArraytoStringText(dst));
     }
   else
      Print("Error in CryptEncode. Error code=",GetLastError());
   return CharArraytoStringText(dst);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Authorized::Decode(string srcstr,string key_arr_string)
  {
   uchar src[],key_arr[],dst[];
   StringToCharArray(key_arr_string,key_arr);
   StringTexttoCharArray(srcstr,src);
//Print("src",srcstr);
//ArrayPrint(src);
//--- 解码 dst[] 到 src[] 
   int res=CryptDecode(CRYPT_DES,src,key_arr,dst);
   if(res>0)
     {
      //--- 打印解码数据 
      //PrintFormat("Decoded data: size=%d, string='%s'",ArraySize(dst),CharArrayToString(dst));
     }
   else
      Print("Error in CryptDecode. Error code=",GetLastError());
   return CharArrayToString(dst);
  }
//+------------------------------------------------------------------+
string Authorized::CharArraytoStringText(uchar &arr[])
  {
   string res="";
   for(int i=0; i<ArraySize(arr); i++)
     {
      res+=string(arr[i])+"/";
     }
   return res;
  }
//+------------------------------------------------------------------+
void Authorized::StringTexttoCharArray(string stringtext,uchar &arr[])
  {
   string sep="/";                // 分隔符为字符 
   ushort u_sep;                  // 分隔符字符代码 
   string result[];               // 获得字符串数组 
//--- 获得分隔符代码 
   u_sep=StringGetCharacter(sep,0);
//--- 字符串分为子字符串 
   int k=StringSplit(stringtext,u_sep,result);
//Print("result");
//ArrayPrint(result);
//--- 显示注释  
//PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
//--- 现在输出所有获得的字符串 
//ArrayInitialize(arr,0);
   int size=ArraySize(result)-1;
   ArrayResize(arr,size);
   if(k>0)
     {
      for(int i=0;i<size;i++)
        {
         arr[i]=char(result[i]);
        }
     }
//Print("chararr");
//ArrayPrint(arr);
  }
#endif 
//+------------------------------------------------------------------+
