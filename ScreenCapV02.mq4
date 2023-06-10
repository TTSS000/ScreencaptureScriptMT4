//+------------------------------------------------------------------+
//|                                                    ScreenCap.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, gogojungle"
#property link      "http://labo.fx-on.com"
#property version   "1.00"
#property strict
//#property  show_confirm
#property  show_inputs

input int adjust_width = 46;
input int adjust_height = 25;
input int adjust_shift = 2;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart(){
   takePicture();
}

bool takePicture(string file_name=NULL){
   int width = 0;
   int height = 0;
   int subwindow_height = 0;
   int sub_count = 1;
   datetime dtlocal = TimeLocal();
   long lFirstVisibleBarShift = ChartGetInteger(0, CHART_FIRST_VISIBLE_BAR, 0);
   
   //デフォルトファイル名 通貨ペア名_時刻.png
   if(file_name == NULL){
      //file_name  = Symbol() + "_";
      //file_name += IntegerToString(Year());
      //if(Month() < 10) file_name += "0";
      //file_name += IntegerToString(Month());
      //if(Day() < 10) file_name += "0";
      //file_name += IntegerToString(Day());
      //if(Hour() < 10) file_name += "0";
      //file_name += IntegerToString(Hour());
      //if(Minute() < 10) file_name += "0";
      //file_name += IntegerToString(Minute());
      //if(Seconds() < 10) file_name += "0";
      //file_name += IntegerToString(Seconds());
      //file_name += ".png";

      file_name += (IntegerToString(TimeYear(dtlocal))+".");
      if(TimeMonth(dtlocal) < 10) file_name += "0";
      file_name += (IntegerToString(TimeMonth(dtlocal))+".");
      if(TimeDay(dtlocal) < 10) file_name += "0";
      file_name += (IntegerToString(TimeDay(dtlocal))+" ");
      if(TimeHour(dtlocal) < 10) file_name += "0";
      file_name += (IntegerToString(TimeHour(dtlocal))+"-");
      if(TimeMinute(dtlocal) < 10) file_name += "0";
      file_name += (IntegerToString(TimeMinute(dtlocal))+"-");
      if(TimeSeconds(dtlocal) < 10) file_name += "0";
      file_name += (IntegerToString(TimeSeconds(dtlocal))+"JST ");
      file_name += (Symbol()+".png");
   }
   
   //サブウィンドウの合計高さを取得
   while(true){
      if(ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, sub_count) > 0){
         subwindow_height += (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, sub_count);
      }
      else break;
      sub_count++;
   }
   
   //画像の横幅と高さを設定
   //width = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0) + 45;
   width = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0) + adjust_width;
   //height = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0) + subwindow_height + 20;
   height = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0) + subwindow_height + adjust_height;
   
   ChartRedraw();
   //ChartNavigate(0, CHART_END, (int)lFirstVisibleBarShift);
    //bool  WindowScreenShot(
    //   string             filename,                   // ファイル名
    //   int                size_x,                      // 幅
    //   int                size_y,                     // 高さ
    //   int                start_bar=-1,               // 開始バー位置
    //   int                chart_scale=-1,                     // チャートスケール
    //   int                chart_mode=-1                     // 表示モード
    //   );


   //if(ChartScreenShot(0, file_name, width, height, ALIGN_LEFT) == false){
   if(WindowScreenShot(file_name, width, height, lFirstVisibleBarShift+adjust_shift, -1, -1) == false){
      Print(__FUNCTION__ + " ErrorCode:" + IntegerToString(GetLastError()));
      return(false);
   }
   
   //ChartNavigate(0, CHART_END, (int)lFirstVisibleBarShift);
   //PlaySound("news.wav");
   return(true);
}
//+------------------------------------------------------------------+
