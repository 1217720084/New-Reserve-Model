*=====================================================================================
* Name:                 vSPDreport.gms
* Function:             Creates the detailed reports for normal SPD mode
* Developed by:         Tuong Nguyen - Electricity Authority, New Zealand
* Source:               https://github.com/ElectricityAuthority/vSPD
*                       http://www.emi.ea.govt.nz/Tools/vSPD
* Contact:              Forum: http://www.emi.ea.govt.nz/forum/
*                       Email: emi@ea.govt.nz
* Last modified on:     23 Sept 2016
*=====================================================================================

Parameters
  o_EnrgViol_TP(dt)                            'Energy violation for summary report'
  o_RampRateViol_TP(dt)                        'Ramp rate violation  for summary report'
  o_BrGroupConstViol_TP(dt)                    'Branch group constraint violation for summary report'
  o_MnodeConstViol_TP(dt)                      'Market node constraint violation for summary report'

;

o_EnrgViol_TP(dt)          = o_DefGenViolation_TP(dt)
                           + o_SurpGenViolation_TP(dt);
o_RampRateViol_TP(dt)      = o_DefRampRate_TP(dt)
                           + o_SurpRampRate_TP(dt) ;
o_BrGroupConstViol_TP(dt)  = o_DefBranchGroupConst_TP(dt)
                           + o_SurpBranchGroupConst_TP(dt);
o_MnodeConstViol_TP(dt)    = o_DefMnodeConst_TP(dt)
                           + o_SurpMnodeConst_TP(dt) ;
*=====================================================================================
* Writing data in to CSV result files
*=====================================================================================

* Trading period level report
$if not exist "%outputPath%\%runName%\%runName%_BusResults_TP.csv" $goto SkipTP

* Trading period summary result
File
SummaryResults_TP / "%outputPath%\%runName%\%runName%_SummaryResults_TP.csv" / ;
SummaryResults_TP.pc = 5 ;    SummaryResults_TP.lw = 0 ;
SummaryResults_TP.pw = 9999 ; SummaryResults_TP.ap = 1 ;
SummaryResults_TP.nd = 5 ;
put SummaryResults_TP ;
loop( dt,
    put dt.tl, o_solveOK_TP(dt), o_ofv_TP(dt)
        o_systemCost_TP(dt), o_systemBenefit_TP(dt), o_penaltyCost_TP(dt)
        o_EnrgViol_TP(dt), o_DefResv_TP(dt), o_SurpBranchFlow_TP(dt)
        o_RampRateViol_TP(dt), o_BrGroupConstViol_TP(dt)
        o_MnodeConstViol_TP(dt) / ;
) ;

* Trading period island result
File IslandResults_TP /"%outputPath%\%runName%\%runName%_IslandResults_TP.csv"/;
IslandResults_TP.pc = 5 ;     IslandResults_TP.lw = 0 ;
IslandResults_TP.pw = 9999 ;  IslandResults_TP.ap = 1 ;
IslandResults_TP.nd = 5 ;
put IslandResults_TP ;
loop( (dt,ild) $ o_island(dt,ild),
    put dt.tl, ild.tl, o_islandGen_TP(dt,ild), o_islandLoad_TP(dt,ild)
        o_islandClrBid_TP(dt,ild), o_islandBranchLoss_TP(dt,ild)
        o_HVDCFlow_TP(dt,ild), o_HVDCLoss_TP(dt,ild)
        o_islandRefPrice_TP(dt,ild)
        o_ResCleared_TP(dt,ild), o_ResPrice_TP(dt,ild)
        o_FIRReqd_TP(dt,ild), o_SIRReqd_TP(dt,ild), o_LIRReqd_TP(dt,ild)
        o_FIRPrice_TP(dt,ild), o_SIRPrice_TP(dt,ild), o_LIRPrice_TP(dt,ild)
        o_islandEnergyRevenue_TP(dt,ild)
        o_islandLoadCost_TP(dt,ild), o_islandLoadRevenue_TP(dt,ild)
* NIRM output
    o_FirCleared_TP(dt,ild), o_FirSent_TP(dt,ild), o_FirReceived_TP(dt,ild), o_FirEffReport_TP(dt,ild)
    o_SirCleared_TP(dt,ild), o_SirSent_TP(dt,ild), o_SirReceived_TP(dt,ild), o_SirEffReport_TP(dt,ild)
    o_LirCleared_TP(dt,ild), o_LirSent_TP(dt,ild), o_LirReceived_TP(dt,ild), o_SirEffReport_TP(dt,ild)
*NIRM output end
    / ;
) ;

$ifthen.ScarcityReport %scarcityExists%==1
* Trading period scarcity results
File scarcityResults_TP    / "%outputPath%\%runName%\%runName%_ScarcityResults_TP.csv" /;
scarcityResults_TP.pc = 5 ;      scarcityResults_TP.lw = 0 ;
scarcityResults_TP.pw = 9999 ;   scarcityResults_TP.ap = 1 ;
scarcityResults_TP.nd = 3 ;
put scarcityResults_TP ;
loop( (dt,ild) $ o_island(dt,ild),
    put dt.tl, ild.tl, o_scarcityExists_TP(dt,ild), o_cptPassed_TP(dt,ild)
        o_avgPriorGWAP_TP(dt,ild), o_islandGWAPbefore_TP(dt,ild)
        o_islandGWAPafter_TP(dt,ild), o_scarcityGWAPbefore_TP(dt,ild)
        o_scarcityGWAPafter_TP(dt,ild), o_scarcityScalingFactor_TP(dt,ild)
        o_GWAPthreshold_TP(dt,ild), o_GWAPfloor_TP(dt,ild)
        o_GWAPceiling_TP(dt,ild) / ;
) ;
$endif.ScarcityReport

* Trading period bus result
File BusResults_TP   / "%outputPath%\%runName%\%runName%_BusResults_TP.csv" / ;
BusResults_TP.pc = 5 ;
BusResults_TP.lw = 0 ;
BusResults_TP.pw = 9999 ;
BusResults_TP.ap = 1 ;
BusResults_TP.nd = 3
put BusResults_TP ;
loop( o_bus(dt,b),
    put dt.tl, b.tl, o_busGeneration_TP(dt,b), o_busLoad_TP(dt,b)
        o_busPrice_TP(dt,b), o_busRevenue_TP(dt,b), o_busCost_TP(dt,b)
        o_busDeficit_TP(dt,b), o_busSurplus_TP(dt,b) / ;
) ;

* Trading period node result
File NodeResults_TP  /"%outputPath%\%runName%\%runName%_NodeResults_TP.csv" / ;
NodeResults_TP.pc = 5 ;
NodeResults_TP.lw = 0 ;
NodeResults_TP.pw = 9999 ;
NodeResults_TP.ap = 1 ;
NodeResults_TP.nd = 3 ;
put NodeResults_TP ;
loop( (dt,n) $ o_node(dt,n),
    put dt.tl, n.tl, o_nodeGeneration_TP(dt,n), o_nodeLoad_TP(dt,n)
        o_nodePrice_TP(dt,n), o_nodeRevenue_TP(dt,n), o_nodeCost_TP(dt,n)
        o_nodeDeficit_TP(dt,n), o_nodeSurplus_TP(dt,n) / ;
) ;

* Trading period offer result
File OfferResults_TP  /"%outputPath%\%runName%\%runName%_OfferResults_TP.csv"/ ;
OfferResults_TP.pc = 5 ;      OfferResults_TP.lw = 0 ;
OfferResults_TP.pw = 9999 ;   OfferResults_TP.ap = 1 ;
OfferResults_TP.nd = 3 ;
put OfferResults_TP ;
loop( (dt,o) $ o_offer(dt,o),
    put dt.tl, o.tl, o_offerEnergy_TP(dt,o), o_offerReserve_TP(dt,o)
        o_offerFIR_TP(dt,o), o_offerSIR_TP(dt,o), o_offerLIR_TP(dt,o) / ;
) ;

* Trading period bid result
File BidResults_TP    / "%outputPath%\%runName%\%runName%_BidResults_TP.csv" / ;
BidResults_TP.pc = 5 ;     BidResults_TP.lw = 0 ;
BidResults_TP.pw = 9999 ;  BidResults_TP.ap = 1 ;
BidResults_TP.nd = 3 ;
put BidResults_TP ;
loop( (dt,bd) $ o_bid(dt,bd),
    put dt.tl, bd.tl, o_bidTotalMW_TP(dt,bd), o_bidEnergy_TP(dt,bd) / ;
) ;

* Trading period reserve result
File
ReserveResults_TP /"%outputPath%\%runName%\%runName%_ReserveResults_TP.csv" / ;
ReserveResults_TP.pc = 5 ;    ReserveResults_TP.lw = 0 ;
ReserveResults_TP.pw = 9999 ; ReserveResults_TP.ap = 1 ;
ReserveResults_TP.nd = 3 ;
put ReserveResults_TP ;
loop( (dt,ild) $ o_island(dt,ild),
    put dt.tl, ild.tl
        o_FIRReqd_TP(dt,ild), o_SIRReqd_TP(dt,ild), o_LIRreqd_TP(dt,ild)
        o_FIRPrice_TP(dt,ild), o_SIRPrice_TP(dt,ild), o_LIRPrice_TP(dt,ild)
        o_FIRViolation_TP(dt,ild), o_SIRViolation_TP(dt,ild), o_LIRViolation_TP(dt,ild)
        o_FIRvrMW_TP(dt,ild), o_SIRvrMW_TP(dt,ild), o_LIRvrMW_TP(dt,ild) / ;
) ;

* Trading period branch result
File
BranchResults_TP  / "%outputPath%\%runName%\%runName%_BranchResults_TP.csv" / ;
BranchResults_TP.pc = 5 ;     BranchResults_TP.lw = 0 ;
BranchResults_TP.pw = 9999 ;  BranchResults_TP.ap = 1 ;
BranchResults_TP.nd = 5 ;
put BranchResults_TP ;
loop( (dt,br,frB,toB)
    $ { o_branchToBus_TP(dt,br,toB) and
        o_branchFromBus_TP(dt,br,frB) and o_branch(dt,br)
      },
    put dt.tl, br.tl, frB.tl, toB.tl, o_branchFlow_TP(dt,br)
        o_branchCapacity_TP(dt,br), o_branchDynamicLoss_TP(dt,br)
        o_branchFixedLoss_TP(dt,br), o_branchFromBusPrice_TP(dt,br)
        o_branchToBusPrice_TP(dt,br), o_branchMarginalPrice_TP(dt,br)
        o_branchTotalRentals_TP(dt,br) / ;
) ;

* Trading period branch constraint result
File BrCstrResults_TP
/ "%outputPath%\%runName%\%runName%_BrConstraintResults_TP.csv" / ;
BrCstrResults_TP.pc = 5 ;
BrCstrResults_TP.lw = 0 ;
BrCstrResults_TP.pw = 9999 ;
BrCstrResults_TP.ap = 1 ;
BrCstrResults_TP.nd = 5 ;
put BrCstrResults_TP ;
loop( (dt,brCstr) $ o_brConstraint_TP(dt,brCstr),
    put dt.tl, brCstr.tl, o_brConstraintLHS_TP(dt,brCstr)
        o_brConstraintSense_TP(dt,brCstr), o_brConstraintRHS_TP(dt,brCstr)
        o_brConstraintPrice_TP(dt,brCstr) / ;
) ;

* Trading period market node constraint result
File MnodeCstrResults_TP
/ "%outputPath%\%runName%\%runName%_MnodeConstraintResults_TP.csv" / ;
MnodeCstrResults_TP.pc = 5 ;
MnodeCstrResults_TP.lw = 0 ;
MnodeCstrResults_TP.pw = 9999 ;
MnodeCstrResults_TP.ap = 1 ;
MnodeCstrResults_TP.nd = 5 ;
put MnodeCstrResults_TP ;
loop( (dt,MnodeCstr) $ o_MnodeConstraint_TP(dt,MnodeCstr),
    put dt.tl, MnodeCstr.tl, o_MnodeConstraintLHS_TP(dt,MnodeCstr)
        o_MnodeConstraintSense_TP(dt,MnodeCstr)
        o_MnodeConstraintRHS_TP(dt,MnodeCstr)
        o_MnodeConstraintPrice_TP(dt,MnodeCstr) / ;
) ;

$label SkipTP
*===============================================================================

execute_unload '%outputPath%\%runName%\%runName%_AllData.gdx' ;




