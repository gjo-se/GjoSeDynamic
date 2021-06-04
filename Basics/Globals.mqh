//+------------------------------------------------------------------+
//|                                                      Globals.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

CTradeHedge Trade;
CPending    Pending;
CPositions  Positions;
CBars       Bar;
CTrailing   Trail;
CTimer      Timer;
CNewBar     NewBar;
TCustomCriterionArray   *criterion_Ptr;

int      session1530EndHour;
int      session1530EndMinute;

datetime lastBuyOrderTime;
datetime lastSellOrderTime;

long     positionTickets[];
double   tickVolumeBuffer[];
double   tickVolumeMABuffer[];


//+------------------------------------------------------------------+
