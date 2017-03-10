*=====================================================================================
* Name:                 vSPDreportSetup.gms
* Function:             Creates the report templates for normal SPD run
* Developed by:         Tuong Nguyen - Electricity Authority, New Zealand
* Source:               https://github.com/ElectricityAuthority/vSPD
*                       http://www.emi.ea.govt.nz/Tools/vSPD
* Contact:              Forum: http://www.emi.ea.govt.nz/forum/
*                       Email: emi@ea.govt.nz
* Last modified on:     23 Sept 2016
*=====================================================================================

$include vSPDsettings.inc

File rep "Write a progess report" /"ProgressReport.txt"/ ;
rep.lw = 0 ; rep.ap = 1 ;
putclose rep "vSPDreportSetup started at: " system.date " " system.time /;

* Trade Period Reports

File summaryResults_TP   / "%outputPath%\%runName%\%runName%_SummaryResults_TP.csv" /;
summaryResults_TP.pc = 5; summaryResults_TP.lw = 0; summaryResults_TP.pw = 9999;
put summaryResults_TP 'DateTime', 'SolveStatus (1=OK)', 'SystemOFV'
    'SystemCost', 'SystemBenefit', 'ViolationCost'
    'EnergyViol (MW)', 'ReserveViol (MW)', 'BranchFlowViol (MW)'
    'RampRateViol (MW)', 'BrGroupConstViol (MW)', 'MNodeConstViol (MW)'
;


File islandResults_TP    / "%outputPath%\%runName%\%runName%_IslandResults_TP.csv" /;
islandResults_TP.pc = 5; islandResults_TP.lw = 0; islandResults_TP.pw = 9999;
put islandResults_TP 'DateTime', 'Island', 'Gen (MW)', 'Load (MW)'
    'Bid Load (MW)', 'IslandACLoss (MW)', 'HVDCFlow (MW)', 'HVDCLoss (MW)'
    'ReferencePrice ($/MWh)', 'Reserve (MW)', 'Reserve Price ($/MWh)'
    'FIR_req (MW)', 'SIR_rep (MW)', 'LIR_req (MW)'
    'FIR_price ($/MWh)', 'SIR_price ($/MWh)', 'LIR_price ($/MWh)'
    'GenerationRevenue ($)', 'LoadCost ($)', 'NegativeLoadRevenue ($)'
* NIRM output
    'FIR_Clear', 'FIR_Share', 'FIR_Receive', 'FIR_Effective'
    'SIR_Clear', 'SIR_Share', 'SIR_Receive', 'SIR_Effective'
    'LIR_Clear', 'LIR_Share', 'LIR_Receive', 'LIR_Effective'
*NIRM output end
;


File scarcityResults_TP    / "%outputPath%\%runName%\%runName%_ScarcityResults_TP.csv" /;
scarcityResults_TP.pc = 5; scarcityResults_TP.lw = 0; scarcityResults_TP.pw = 9999;
put scarcityResults_TP 'DateTime', 'Island'
    'Scarcity exists (0=none, 1=island, 2=national)'
    'CPT passed', 'AvgPriorGWAP ($/MWh)', 'IslandGWAP_before ($/MWh)'
    'IslandGWAP_after ($/MWh)', 'ScarcityAreaGWAP_before ($/MWh)'
    'ScarcityAreaGWAP_after ($/MWh)', 'ScarcityScalingFactor'
    'CPT_GWAPthreshold ($/MWh)', 'GWAPfloor ($/MWh)', 'GWAPceiling ($/MWh)';


File busResults_TP       / "%outputPath%\%runName%\%runName%_BusResults_TP.csv" /;
busResults_TP.pc = 5; busResults_TP.lw = 0; busResults_TP.pw = 9999;
put busResults_TP 'DateTime', 'Bus', 'Generation (MW)', 'Load (MW)'
    'Price ($/MWh)', 'Revenue ($)', 'Cost ($)', 'Deficit(MW)', 'Surplus(MW)';


File nodeResults_TP      / "%outputPath%\%runName%\%runName%_NodeResults_TP.csv" /;
nodeResults_TP.pc = 5; nodeResults_TP.lw = 0; nodeResults_TP.pw = 9999;
put nodeResults_TP 'DateTime', 'Node', 'Generation (MW)', 'Load (MW)'
    'Price ($/MWh)', 'Revenue ($)', 'Cost ($)', 'Deficit(MW)', 'Surplus(MW)';


File offerResults_TP     / "%outputPath%\%runName%\%runName%_OfferResults_TP.csv" /;
offerResults_TP.pc = 5; offerResults_TP.lw = 0; offerResults_TP.pw = 9999;
put offerResults_TP 'DateTime', 'Offer', 'Generation (MW)'
    'Reserve', 'FIR (MW)', 'SIR (MW)', 'LIR (MW)' ;


File bidResults_TP       / "%outputPath%\%runName%\%runName%_BidResults_TP.csv" /;
bidResults_TP.pc = 5; bidResults_TP.lw = 0; bidResults_TP.pw = 9999;
put bidResults_TP 'DateTime', 'Bid', 'Total Bid (MW)', 'Cleared Bid (MW)';


File reserveResults_TP   / "%outputPath%\%runName%\%runName%_ReserveResults_TP.csv" /;
reserveResults_TP.pc = 5; reserveResults_TP.lw = 0; reserveResults_TP.pw = 9999;
put reserveResults_TP 'DateTime', 'Island'
    'FIR Reqd (MW)', 'SIR Reqd (MW)', 'LIR Reqd (MW)'
    'FIR Price ($/MW)', 'SIR Price ($/MW)', 'LIR Price ($/MW)'
    'FIR Violation (MW)', 'SIR Violation (MW)', 'LIR Violation (MW)'
    'Virtual FIR (MW)', 'Virtual SIR (MW)' , 'Virtual LIR (MW)' ;


File branchResults_TP    / "%outputPath%\%runName%\%runName%_BranchResults_TP.csv" /;
branchResults_TP.pc = 5; branchResults_TP.lw = 0; branchResults_TP.pw = 9999;
put branchResults_TP 'DateTime', 'Branch', 'FromBus', 'ToBus'
    'Flow (MW) (From->To)', 'Capacity (MW)', 'DynamicLoss (MW)'
    'FixedLoss (MW)', 'FromBusPrice ($/MWh)', 'ToBusPrice ($/MWh)'
    'BranchPrice ($/MWh)', 'BranchRentals ($)' ;


File brCstrResults_TP    / "%outputPath%\%runName%\%runName%_BrConstraintResults_TP.csv" /;
brCstrResults_TP.pc = 5; brCstrResults_TP.lw = 0; brCstrResults_TP.pw = 9999;
put brCstrResults_TP 'DateTime', 'BranchConstraint', 'LHS (MW)'
    'Sense (-1:<=, 0:=, 1:>=)', 'RHS (MW)', 'Price ($/MWh)' ;


File MNodeCstrResults_TP / "%outputPath%\%runName%\%runName%_MNodeConstraintResults_TP.csv" /;
MNodeCstrResults_TP.pc = 5; MNodeCstrResults_TP.lw = 0; MNodeCstrResults_TP.pw = 9999 ;
put MNodeCstrResults_TP 'DateTime', 'MNodeConstraint', 'LHS (MW)'
    'Sense (-1:<=, 0:=, 1:>=)', 'RHS (MW)', 'Price ($/MWh)' ;


