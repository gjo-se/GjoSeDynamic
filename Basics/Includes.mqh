//+------------------------------------------------------------------+
//|                                                     Includes.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Inputs.mqh"
#include "Const.mqh"

#include <Mql5Book\TradeHedge.mqh>
#include <Mql5Book\Pending.mqh>
#include <Mql5Book\Price.mqh>
#include <Mql5Book\MoneyManagement.mqh>
#include <Mql5Book\TrailingStops.mqh>
#include <Mql5Book\Timer.mqh>
#include <Mql5Book\Indicators.mqh>
#include <GjoSe\Tester\CustomOptimisation.mqh>
#include <Trade\DealInfo.mqh>


#include "Globals.mqh"
#include "..\\Actions\\InitializeActions.mqh"
#include "..\\Actions\\CleanArraysActions.mqh"
#include "..\\Actions\\TrailingActions.mqh"
#include "..\\Actions\\OpenActions.mqh"
#include "..\\Actions\\CloseActions.mqh"

#include "..\\States\\TriggerBuyInStates.mqh"
#include "..\\States\\TriggerBuyOutStates.mqh"
#include "..\\States\\TriggerSellInStates.mqh"

#include <GjoSe\\Utilities\\InclUtilities.mqh>
#include <GjoSe\\Objects\\InclVLine.mqh>
