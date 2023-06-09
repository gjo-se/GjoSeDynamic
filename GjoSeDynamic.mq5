/*

   EA GjoSeDynamic.mq5
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   1.0.0 Initial version

   ===============

*/
//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\Includes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2021, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe Dynamic"
#define   VERSION "1.0.0-test"
#property version VERSION
#property strict

int tickvolumeHandle;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   initializeEAAction();
   initializeArraysAction();
   initializeGlobalsAction();
   initializeIndicatorsAction();

   criterion_Ptr = new TCustomCriterionArray();
   if(CheckPointer(criterion_Ptr) == POINTER_INVALID) {
      return(-1);
   }
   //criterion_Ptr.Add(new TSimpleCriterion( STAT_PROFIT ));
   //criterion_Ptr.Add(new TSimpleDivCriterion( STAT_EQUITY_DDREL_PERCENT ));

   criterion_Ptr.Add(new TTSSFCriterion());

   return(0);
}


void OnTick() {

//bool tradeOnlyOnNewBar = checkTradeOnlyOnNewBar(InpTradeOnNewBar, InpNewBarTimeframe);
//if(isNewBar == true)

   NewBar.CheckNewBarD1(Symbol());
   
   //Print("----------------------OnTick----------------------");
   //Print("session1530EndHour: " + session1530EndHour);
   //Print("session1530EndMinute: " + session1530EndMinute);

   if(session1530EndHour == 0 || isNewBarD1 == true) {
      session1530EndHour = InpEndHour;
      session1530EndMinute = InpEndMinute;
   }
   
   Bar.Update(Symbol(), Period());
   
   bool tradeOnlyOnTradingTime = checkTradeOnlyOnTradingTime(InpUseTimer, InpStartHour, InpStartMinute, session1530EndHour, session1530EndMinute, InpUseLocalTime);
   if( tradeOnlyOnTradingTime == true) {

      

      tickvolumeHandle = iVolumes(Symbol(), InpTickVolumeTimeFrame, VOLUME_TICK);
      ArraySetAsSeries(tickVolumeBuffer, true);
      CopyBuffer(tickvolumeHandle, TICK_VOLUME_BUFFER, 0, InpTickVolumeAVGPeriod, tickVolumeBuffer);


//   Print("tickvolumeHandle: " + tickvolumeHandle);
//
//   int tickVolumeMAHandle = iMA(Symbol(), PERIOD_M1, 3, 0, MODE_SMA, tickvolumeHandle);
//   ArraySetAsSeries(tickVolumeMABuffer, true);
//   CopyBuffer(tickVolumeMAHandle, TICK_VOLUME_MA_BUFFER, 0, 300, tickVolumeMABuffer);

      //int momentumHandle = iMomentum(Symbol(), InpMomentumTimeframe, InpMomentumPeriod, PRICE_CLOSE);
      //ArraySetAsSeries(momentumBuffer, true);
      //CopyBuffer(momentumHandle, MOMENTUM_BUFFER, 0, 3, momentumBuffer);


      Print("Bid(): " + Bid());

      


      if(InpLong == true && getTriggerBuyInSignalState() == true) openBuyOrderAction();
      if(InpShort == true && getTriggerSellInSignalState() == true) openSellOrderAction();
      
      

   }
   
   if(InpUseBreakEven == true) setBreakevenAction();
   if(InpUseTrailingStop == true) setTrailingStopAction();
   if(InpUseCloseOnCandleLow == true && getTriggerBuyOutSignalState() == true) closeBuyOrderAction(CLOSED_BY_CANDLE_LOW);


}

void OnDeinit(const int reason) {

   Comment("");

   if(CheckPointer(criterion_Ptr) == POINTER_DYNAMIC) {
      delete(criterion_Ptr);
   }

   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  OnTester() {
   double   param = 0.0;

// Balance max + min Drawdown + Trades Number:
   if(CheckPointer(criterion_Ptr) != POINTER_INVALID) {
      param = criterion_Ptr.GetCriterion();
   }

   return(param);
}
//+------------------------------------------------------------------+
