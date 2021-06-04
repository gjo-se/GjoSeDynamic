/*

   TriggerBuyInStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getTriggerSellInSignalState() {

   bool signal = false;

   if(getVolumeSellInSignal() == true) signal = true;
   if(getOpenSellPositionsFilter() == true) signal = false;
   if(isGreenCandleFilter() == true) signal = false;
   //if(getMomentumSellInFilter() == true) signal = false;
   if(getSleepSellInFilter() == true) signal = false;

   return(signal);

}
//+------------------------------------------------------------------+

bool getVolumeSellInSignal() {

   bool signal = false;
   int currentBarShift = 0;
   int lastBarShift = 1;
   long currentVolume = tickVolumeBuffer[currentBarShift];
   long lastVolume = tickVolumeBuffer[lastBarShift];

   if(currentVolume > InpSellMinTickVolume && currentVolume > lastVolume) signal = true;

   return(signal);

}

//+------------------------------------------------------------------+
bool getOpenSellPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(PositionType(positionTicket) == ORDER_TYPE_SELL) filter = true;
   }

   return (filter);
}
//+------------------------------------------------------------------+

//bool getMomentumSellInFilter() {
//
//   bool filter = false;
//   int barShift = 0;
//
//   if(momentumBuffer[barShift] > InpMaxMomentumValue) filter = true;
//
//   return(filter);
//
//}

bool isGreenCandleFilter() {

   bool filter = false;

   if(Bar.Open() < Bid()) filter = true;

   return (filter);
}
//+------------------------------------------------------------------+

bool getSleepSellInFilter() {

   bool filter = false;
   int WaitTime = 10;  // 10 Min.

   if (TimeCurrent() < lastSellOrderTime + (WaitTime * 60)) {
      filter = true;
   }

   return (filter);
}
//+------------------------------------------------------------------+
