//+------------------------------------------------------------------+
//|                                                 CloseActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void closeBuyOrderAction(string pComment) {

   long positionTicket = 0;
   int positionProfitPoints = 0;

   for(int positionTicketIndex = 0; positionTicketIndex < ArraySize(positionTickets); positionTicketIndex++) {
      positionTicket = positionTickets[positionTicketIndex];
      string comment = pComment + "_" + IntegerToString(positionTicket);
      positionProfitPoints = getProfitInPoints(positionTicket);
      if(PositionType(positionTicket) == ORDER_TYPE_BUY && positionProfitPoints > InpBreakEvenProfit) {
         Trade.Close(positionTicket, PositionVolume(positionTicket), comment);
      }

   }

   cleanPositionTicketsArrayAction();

}
//+------------------------------------------------------------------+
