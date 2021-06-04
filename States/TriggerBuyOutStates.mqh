/*

   TriggerBuyOutStates
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Beschreibung
   ===============

*/

bool getTriggerBuyOutSignalState() {

   bool signal = false;

   if(getBidLowerLastCandleLowSignal() == true) signal = true;

   return(signal);

}

bool getBidLowerLastCandleLowSignal() {

   bool signal = false;
   int barShift = 1;

   if(Bid() < Bar.Low(barShift)) signal = true;

   return(signal);

}