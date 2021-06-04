//+------------------------------------------------------------------+
//|                                                  OpenActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void openBuyOrderAction() {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = BuyStopLoss(Symbol(), InpBuyStopLoss, Ask());
   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   double takeProfit = BuyTakeProfit(Symbol(), InpBuyTakeProfit, Ask());
   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, InpComment);

   cleanPositionTicketsArrayAction();

   sleepRestOfSession(0);

   createVLine(__FUNCTION__ + Bar.Open(), Bar.Time(1));

}
//+------------------------------------------------------------------+

void openSellOrderAction() {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = SellStopLoss(Symbol(), InpSellStopLoss, Ask());
   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   double takeProfit = SellTakeProfit(Symbol(), InpSellTakeProfit, Ask());
   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, InpComment);

   cleanPositionTicketsArrayAction();

   lastSellOrderTime = TimeCurrent();
}
//+------------------------------------------------------------------+
