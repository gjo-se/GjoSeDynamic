//+------------------------------------------------------------------+
//|                                             InitializeAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void initializeEAAction() {

   Trade.Deviation(InpMaxSlippage);
   Trade.MagicNumber(InpMagicNumber);

}
//+------------------------------------------------------------------+
void initializeGlobalsAction() {

   isNewBar = false;
   isNewBarM1 = false;
   isNewBarD1 = false;

   session1530EndHour = 0;
   session1530EndMinute = 0;

   lastBuyOrderTime = 0;
   lastSellOrderTime = 0;

}
//+------------------------------------------------------------------+
void initializeArraysAction() {
   initializeArray(positionTickets, 100);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeIndicatorsAction() {

   SetIndexBuffer(TICK_VOLUME_BUFFER, tickVolumeBuffer);
//SetIndexBuffer(TICK_VOLUME_MA_BUFFER, tickVolumeMABuffer);
//SetIndexBuffer(MOMENTUM_BUFFER, momentumBuffer);

//iMA(Symbol(), PERIOD_M1, 3, 0, MODE_SMA, tickvolumeHandle);
//SGL_MA.Init(Symbol(), InpSGL_MATimeframe, InpSGL_MAPeriod, InpSGL_MAShift, InpSGL_MAMethod, tickvolumeHandle);
//SGL_MA.Init(Symbol(), PERIOD_M1, 30, 0, MODE_SMA, PRICE_CLOSE);
}
//+------------------------------------------------------------------+
