/*

   TriggerBuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getTriggerBuyInSignalState() {

   bool signal = true;

   //Print("-------------------getTriggerBuyInSignalState---------------------------------:");

   if(getOpenBuyPositionsFilter() == true) signal = false;
   if(isRedCandleFilter() == true) signal = false;

   if(getMomentumIsLowerMINMomentumBuyInFilter() == true) signal = false;
   if(getMomentumIsHigherMAXMomentumBuyInFilter() == true) signal = false;
   if(getMomentumIsLowerHighestHighBuyInFilter() == true) signal = false;

   //if(getVolumeBuyInFilter() == true) signal = false;

   if(getMaxCandleFuseBuyInFilter() == true) signal = false;
   if(getMaxCandleWickBuyInFilter() == true) signal = false;

   return(signal);

}
//+------------------------------------------------------------------+

bool getVolumeBuyInFilter() {

   bool   filter = true;
   int    currentBarShift = 0;
   int    lastBarShift = 1;
   double currentVolume = tickVolumeBuffer[currentBarShift];
   double lastVolume = tickVolumeBuffer[lastBarShift];
   double avgTickVolume = 0;
   double destinationVolumePerSeconde;
   double tickVolumeSum = 0;
   int    candleOpenSinceSeconds = (int)TimeCurrent() - (int)Bar.Time();
   double currentVolumeperSeconde = 0;

   for(int tickVolumeId = 0; tickVolumeId < ArraySize(tickVolumeBuffer); tickVolumeId++) {
      tickVolumeSum += tickVolumeBuffer[tickVolumeId];
   }

   avgTickVolume = tickVolumeSum / ArraySize(tickVolumeBuffer);

   destinationVolumePerSeconde = avgTickVolume * InpTickVolumeAVGSpeedMulti / 60 / 1000;
   if(candleOpenSinceSeconds > 0) currentVolumeperSeconde = currentVolume / candleOpenSinceSeconds / 1000;

   if(currentVolume > 0 && currentVolumeperSeconde > 0) {
      if(currentVolume > (avgTickVolume * InpTickVolumeAVGMinMulti) && currentVolumeperSeconde > destinationVolumePerSeconde) {
         filter = false;
         sleepRestOfSession();
      } else {
         //Print("getVolumeBuyInFilter");
      }

   }


   return(filter);

}

bool getMomentumIsLowerMINMomentumBuyInFilter() {

   bool     filter = true;

   int      candlesForRangeAvg = 30;
   double   candlesForRangeAvgSum = 0;
   double   candleRangeAvg = 0;
   double   barHigh = 0;
   double   barLow = 0;
   double   currentMomentum = 0;
   double   currentMomentumPerSeconde = 0;
   double   destinationMomentumPerSeconde = 0;
   int      candleOpenSinceSeconds = (int)TimeCurrent() - (int)Bar.Time();

   for(int candleId = 1; candleId <= candlesForRangeAvg; candleId++) {
      barHigh = Bar.High(candleId) / Point();
      barLow = Bar.Low(candleId) / Point();
      candlesForRangeAvgSum += MathMax(barHigh, barLow) - MathMin(barHigh, barLow);
   }

   candleRangeAvg = candlesForRangeAvgSum / candlesForRangeAvg;
   destinationMomentumPerSeconde = candleRangeAvg * InpMomentumAVGSpeedMulti / 60 / 1000;

   currentMomentum = (Bid() / Point()) - (Bar.Open() / Point());

   if(candleOpenSinceSeconds > 0) currentMomentumPerSeconde = currentMomentum / candleOpenSinceSeconds / 1000;

   if(currentMomentum > (candleRangeAvg * InpMomentumAVGMinMulti) && currentMomentumPerSeconde > destinationMomentumPerSeconde) {
      filter = false;
      sleepRestOfSession();
      //Print("MomentumFilter isFalse, also Sleep");
   } else {
      //Print("getMomentumIsLowerMINMomentumBuyInFilter");
   }

   return (filter);
}

bool getMomentumIsHigherMAXMomentumBuyInFilter() {

   bool filter = false;
   double momentumMaxToLowestLow = InpMomentumMaxToLowestLow * Point();

   if(Bid() > LowestLow(Symbol(), PERIOD_M1, 5) + momentumMaxToLowestLow) {
      filter = true;
      //Print("getMomentumIsHigherMAXMomentumBuyInFilter");
   }

   return (filter);
}
//+------------------------------------------------------------------+


bool getMomentumIsLowerHighestHighBuyInFilter() {

   bool filter = false;
   double momentumMinToHighestHigh = InpMomentumMinToHighestHigh * Point();
   int candles = 5;
   int barShift = 1;
   double highestHigh = HighestHigh(Symbol(), PERIOD_M1, candles, barShift);

   if(Bid() < (highestHigh + momentumMinToHighestHigh)) {
      filter = true;
      //Print("getMomentumIsLowerHighestHighBuyInFilter");
   }

   return (filter);
}


bool getOpenBuyPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(PositionType(positionTicket) == ORDER_TYPE_BUY) filter = true;
   }

   return (filter);
}
//+------------------------------------------------------------------+

bool isRedCandleFilter() {

   bool filter = false;

   if(Bar.Open() > Bid()) {
      filter = true;
      //Print("isRedCandleFilter");
   }

   return (filter);
}

//+------------------------------------------------------------------+

bool getMaxCandleFuseBuyInFilter() {

   bool filter = false;
   int   barOpen = Bar.Open() / Point();
   int   barLow = Bar.Low() / Point();

   if((barOpen - barLow) > InpMaxCandleFuse) {
      filter = true;
      //Print("getMaxCandleFuseBuyInFilter");
      //sleepRestOfSession();
   }

   return (filter);
}

bool getMaxCandleWickBuyInFilter() {

   bool filter = false;
   int   barHigh = Bar.High() / Point();
   int   bid = Bid() / Point();

   if((barHigh - bid) > InpMaxCandleWick) {
      filter = true;
      //Print("getMaxCandleWickBuyInFilter");
      //sleepRestOfSession();
   }

   return (filter);
}

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void sleepRestOfSession(int pNextBar = 1) {
   session1530EndHour = getHour();
   session1530EndMinute = getMinute() + pNextBar;
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getHour() {
   MqlDateTime timeStruct;
   TimeToStruct(TimeCurrent(), timeStruct);

   return(timeStruct.hour);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getMinute() {
   MqlDateTime timeStruct;
   TimeToStruct(TimeCurrent(), timeStruct);

   return(timeStruct.min);
}
//+------------------------------------------------------------------+
