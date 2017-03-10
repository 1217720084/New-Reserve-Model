Sets
* 22 hard-coded sets. Although these 22 sets exist in the vSPD input GDX file, they are not loaded from
* the GDX file. Rather, all but caseName are initialsed via hard-coding in vSPDsolve.gms prior to data
* being loaded from the GDX file. They are declared now because they're used in the domain of other symbols.
  caseName(*)                              'Final pricing case name used to create the GDX file'
  i_island(*)                              'Islands'
  i_tradeBlock(*)                          'Trade block definitions (or tranches) - used for the offer and bids'
  i_CVP(*)                                 'Constraint violation penalties used in the model'
  i_offerType(*)                           'Type of energy and reserve offers from market participants'
  i_offerParam(*)                          'The various parameters required for each offer'
  i_energyOfferComponent(*)                'Components of the energy offer - comprised of MW capacity and price by tradeBlock'
  i_PLSRofferComponent(*)                  'Components of the PLSR offer - comprised of MW proportion and price by tradeBlock'
  i_TWDRofferComponent(*)                  'Components of the TWDR offer - comprised of MW capacity and price by tradeBlock'
  i_ILRofferComponent(*)                   'Components of the ILR offer - comprised of MW capacity and price by tradeBlock'
  i_energyBidComponent(*)                  'Components of the energy bid - comprised of MW capacity and price by tradeBlock'
  i_ILRbidComponent(*)                     'Components of the ILR provided by bids'
  i_riskClass(*)                           'Different risks that could set the reserve requirements'
  i_reserveType(*)                         'Definition of the different reserve types (PLSR, TWDR, ILR)'
  i_reserveClass(*)                        'Definition of fast and sustained instantaneous reserve'
  i_riskParameter(*)                       'Different risk parameters that are specified as inputs to the dispatch model'
  i_branchParameter(*)                     'Branch parameter specified'
  i_lossSegment(*)                         'Loss segments available for loss modelling'
  i_lossParameter(*)                       'Components of the piecewise loss function'
  i_constraintRHS(*)                       'Constraint RHS definition'
  i_flowDirection(*)                       'Directional flow definition used in the SPD formulation'
* 14 fundamental sets - membership is assigned when symbols are loaded from the GDX file in vSPDsolve.gms
  i_dateTime(*)                            'Date and time for the trade periods'
  i_tradePeriod(*)                         'Trade periods for which input data is defined'
  i_node(*)                                'Node definitions for all trading periods'
  i_offer(*)                               'Offers for all trading periods'
  i_trader(*)                              'Traders defined for all trading periods'
  i_bid(*)                                 'Bids for all trading periods'
  i_bus(*)                                 'Bus definitions for all trading periods'
  i_branch(*)                              'Branch definition for all trading periods'
  i_branchConstraint(*)                    'Branch constraint definitions for all trading periods'
  i_MnodeConstraint(*)                     'Market node constraint definitions for all trading periods'
* Scarcity pricing updates
  i_scarcityArea(*)                        'Area to which scarcity pricing may apply'
* Risk group
  i_riskGroup(*)                           'Set representing a collection of generation and reserve offers treated as a group risk'
  ;

* Aliases
Alias (i_dateTime,dt),                      (i_tradePeriod,tp,tp1),             (i_island,ild,ild1)
      (i_bus,b,b1,toB,frB),                 (i_node,n,n1),                      (i_offer,o,o1)
      (i_trader,trdr),                      (i_tradeBlock,trdBlk),              (i_branch,br,br1)
      (i_branchConstraint,brCstr),          (i_MnodeConstraint,MnodeCstr)
      (i_energyOfferComponent,NRGofrCmpnt), (i_PLSRofferComponent,PLSofrCmpnt), (i_TWDRofferComponent,TWDofrCmpnt)
      (i_ILRofferComponent,ILofrCmpnt),     (i_energyBidComponent,NRGbidCmpnt), (i_ILRbidComponent,ILbidCmpnt)
      (i_scarcityArea,sarea),               (i_lossSegment,los,los1,bp,bp1,rsbp,rsbp1)
      (i_bid,bd,bd1),                       (i_flowDirection,fd,fd1,rd,rd1),    (i_reserveType,resT)
      (i_reserveClass,resC,resC1),          (i_riskClass,riskC),                (i_constraintRHS,CstrRHS)
      (i_riskParameter,riskPar),            (i_offerParam,offerPar),            (i_riskGroup,rg,rg1)
  ;

Sets
* 16 multi-dimensional sets, subsets, and mapping sets - membership is populated via loading from GDX file in vSPDsolve.gms
  i_dateTimeTradePeriodMap(dt,tp)                                   'Mapping of dateTime set to the tradePeriod set'
  i_tradePeriodNode(tp,n)                                           'Node definition for the different trading periods'
  i_tradePeriodOfferNode(tp,o,n)                                    'Offers and the corresponding offer node for the different trading periods'
  i_tradePeriodOfferTrader(tp,o,trdr)                               'Offers and the corresponding trader for the different trading periods'
  i_tradePeriodBidNode(tp,bd,n)                                     'Bids and the corresponding node for the different trading periods'
  i_tradePeriodBidTrader(tp,bd,trdr)                                'Bids and the corresponding trader for the different trading periods'
  i_tradePeriodBus(tp,b)                                            'Bus definition for the different trading periods'
  i_tradePeriodNodeBus(tp,n,b)                                      'Node bus mapping for the different trading periods'
  i_tradePeriodBusIsland(tp,b,ild)                                  'Bus island mapping for the different trade periods'
  i_tradePeriodBranchDefn(tp,br,frB,toB)                            'Branch definition for the different trading periods'
  i_tradePeriodRiskGenerator(tp,o)                                  'Set of generators (offers) that can set the risk in the different trading periods'
* 1 set loaded from GDX with conditional load statement in vSPDsolve.gms at execution time
  i_tradePeriodPrimarySecondaryOffer(tp,o,o1)                       'Primary-secondary offer mapping for the different trading periods'
* MODD Modification
  i_tradePeriodDispatchableBid(tp,bd)                               'Set of dispatchable bids'
* Risk group offer mapping
  i_tradePeriodRiskGroup(tp,rg,o,riskC)                             'Mappimg of risk group to offers in current trading period for each risk class - SPD version 11.0 update'
  i_tradePeriodRampingConstraint(tp,brCstr)                         'Subset of branch constraints that limit total HVDC sent from an island due to ramping (5min schedule only)'
  ;

Parameters
* 6 scalars - values are loaded from GDX file in vSPDsolve.gms
  i_day                                                             'Day number (1..31)'
  i_month                                                           'Month number (1..12)'
  i_year                                                            'Year number (1900..2200)'
  i_tradingPeriodLength                                             'Length of the trading period in minutes (e.g. 30)'
* 49 parameters - values are loaded from GDX file in vSPDsolve.gms
  i_StudyTradePeriod(tp)                                            'Trade periods that are to be studied'
  i_CVPvalues(i_CVP)                                                'Values for the constraint violation penalties'
* Offer data
  i_tradePeriodOfferParameter(tp,o,i_offerParam)                    'Initial MW for each offer for the different trading periods'
  i_tradePeriodEnergyOffer(tp,o,trdBlk,NRGofrCmpnt)                 'Energy offers for the different trading periods'
  i_tradePeriodSustainedPLSRoffer(tp,o,trdBlk,PLSofrCmpnt)          'Sustained (60s) PLSR offers for the different trading periods'
  i_tradePeriodFastPLSRoffer(tp,o,trdBlk,PLSofrCmpnt)               'Fast (6s) PLSR offers for the different trading periods'
  i_tradePeriodSustainedTWDRoffer(tp,o,trdBlk,TWDofrCmpnt)          'Sustained (60s) TWDR offers for the different trading periods'
  i_tradePeriodFastTWDRoffer(tp,o,trdBlk,TWDofrCmpnt)               'Fast (6s) TWDR offers for the different trading periods'
  i_tradePeriodSustainedILRoffer(tp,o,trdBlk,ILofrCmpnt)            'Sustained (60s) ILR offers for the different trading periods'
  i_tradePeriodFastILRoffer(tp,o,trdBlk,ILofrCmpnt)                 'Fast (6s) ILR offers for the different trading periods'
* Demand data
  i_tradePeriodNodeDemand(tp,n)                                     'MW demand at each node for all trading periods'
* Bid data
  i_tradePeriodEnergyBid(tp,bd,trdBlk,NRGbidCmpnt)                  'Energy bids for the different trading periods'
* Network data
  i_tradePeriodHVDCNode(tp,n)                                       'HVDC node for the different trading periods'
  i_tradePeriodReferenceNode(tp,n)                                  'Reference nodes for the different trading periods'
  i_tradePeriodHVDCBranch(tp,br)                                    'HVDC branch indicator for the different trading periods'
  i_tradePeriodBranchParameter(tp,br,i_branchParameter)             'Branch resistance, reactance, fixed losses and number of loss tranches for the different time periods'
  i_tradePeriodBranchCapacity(tp,br)                                'Branch capacity for the different trading periods in MW'
  i_tradePeriodBranchOpenStatus(tp,br)                              'Branch open status for the different trading periods, 1 = Open'
  i_noLossBranch(los,i_lossParameter)                               'Loss parameters for no loss branches'
  i_AClossBranch(los,i_lossParameter)                               'Loss parameters for AC loss branches'
  i_HVDClossBranch(los,i_lossParameter)                             'Loss parameters for HVDC loss branches'
  i_tradePeriodNodeBusAllocationFactor(tp,n,b)                      'Allocation factor of market node quantities to bus for the different trading periods'
  i_tradePeriodBusElectricalIsland(tp,b)                            'Electrical island status of each bus for the different trading periods (0 = Dead)'
* Risk/Reserve data
  i_tradePeriodRiskParameter(tp,ild,resC,riskC,riskPar)             'Risk parameters for the different trading periods (From RMT)'
  i_tradePeriodManualRisk(tp,ild,resC)                              'Manual risk set for the different trading periods'
* Branch constraint data
  i_tradePeriodBranchConstraintFactors(tp,brCstr,br)                'Branch constraint factors (sensitivities) for the different trading periods'
  i_tradePeriodBranchConstraintRHS(tp,brCstr,CstrRHS)               'Branch constraint sense and limit for the different trading periods'
* Market node constraint data
  i_tradePeriodMNodeEnergyOfferConstraintFactors(tp,MnodeCstr,o)                'Market node energy offer constraint factors for the different trading periods'
  i_tradePeriodMNodeReserveOfferConstraintFactors(tp,MnodeCstr,o,resC,resT)     'Market node reserve offer constraint factors for the different trading periods'
  i_tradePeriodMNodeEnergyBidConstraintFactors(tp,MnodeCstr,bd)                 'Market node energy bid constraint factors for the different trading periods'
  i_tradePeriodMNodeConstraintRHS(tp,MnodeCstr,CstrRHS)                         'Market node constraint sense and limit for the different trading periods'
* 11 parameters loaded from GDX with conditional load statement at execution time
  i_tradePeriodAllowHVDCRoundpower(tp)                              'Flag to allow roundpower on the HVDC (1 = Yes)'
  i_tradePeriodManualRisk_ECE(tp,ild,resC)                          'Manual ECE risk set for the different trading periods'
  i_tradePeriodHVDCSecRiskEnabled(tp,ild,riskC)                     'Flag indicating if the HVDC secondary risk is enabled (1 = Yes)'
  i_tradePeriodHVDCSecRiskSubtractor(tp,ild)                        'Ramp up capability on the HVDC pole that is not the secondary risk'
  i_tradePeriodReserveClassGenerationMaximum(tp,o,resC)             'MW used to determine factor to adjust maximum reserve of a reserve class'
* Virtual reserve
 i_tradePeriodVROfferMax(tp,ild,resC)                               'Maximum MW of the virtual reserve offer'
 i_tradePeriodVROfferPrice(tp,ild,resC)                             'Price of the virtual reserve offer'
* Scarcity pricing
 i_tradePeriodScarcitySituationExists(tp,*)                         'Flag to indicate that a scarcity situation exists (1 = Yes)'
 i_tradePeriodGWAPFloor(tp,*)                                   'Floor price for the scarcity situation in scarcity area'
 i_tradePeriodGWAPCeiling(tp,*)                                 'Ceiling price for the scarcity situation in scarcity area'
 i_tradePeriodGWAPPastDaysAvg(tp,ild)                               'Average GWAP over past days - number of periods in GWAP count'
 i_tradePeriodGWAPCountForAvg(tp,ild)                               'Number of periods used for the i_gwapPastDaysAvg'
 i_tradePeriodGWAPThreshold(tp,ild)                                 'Threshold on previous 336 trading period GWAP - cumulative price threshold'
* The follwing are new input for NMIR
  i_tradePeriodReserveRoundPower(tp,resC)                                        'Database flag that disables round power under certain circumstances'
  i_tradePeriodReserveSharing(tp,resC)                                      'Database flag if reserve class resC is sharable'
  i_tradePeriodModulationRisk(tp,riskC)                                     'HVDC energy modulation due to frequency keeping action'
  i_tradePeriodRoundPower2Mono(tp)                                          'HVDC sent value above which one pole is stopped and therefore FIR cannot use round power'
  i_tradePeriodBipole2Mono(tp)                                              'HVDC sent value below which one pole is available to start in the opposite direction and therefore SIR can use round power'
  i_tradePeriodReserveSharingPoleMin(tp)                                               'The lowest level that the sent HVDC sent can ramp down to when round power is not available.'
  i_tradePeriodHVDCcontrolBand(tp,rd)                                            'Modulation limit of the HVDC control system apply to each HVDC direction'
  i_tradePeriodHVDClossScalingFactor(tp)                                         'Losses used for full voltage mode are adjusted by a factor of (700/500)^2 for reduced voltage operation'
  i_tradePeriodSharedNFRfactor(tp)                                               'Factor that is applied to [sharedNFRLoad - sharedNFRLoadOffset] as part of the calculation of sharedNFRMax'
  i_tradePeriodSharedNFRLoadOffset(tp,ild)                                       'Island load that does not provide load damping, e.g., Tiwai smelter load in the South Island. Subtracted from the sharedNFRLoad in the calculation of sharedNFRMax.'
  i_tradePeriodReserveEffectiveFactor(tp,ild,resC,riskC)                                'Estimate of the effectiveness of the shared reserve once it has been received in the risk island.'
  i_tradePeriodRMTreserveLimit(tp,ild,resC)

* New reserve offer data
  i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt)                   'PLSR offers for the different trading periods'
  i_tradePeriodPLSRfactor(tp,o,resC)                                'PLSR offer reserve class factor for the different trading periods'
  i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt)                   'TWDR offers for the different trading periods'
  i_tradePeriodTWDRfactor(tp,o,resC)                                'TWDR offer reserve class factor for the different trading periods'
  i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt)                     'ILR offers for the different trading periods'
  i_tradePeriodILRfactor(tp,o,resC)                                 'ILR offer reserve class factor for the different trading periods'

;
* End of GDX declarations

Sets
  i_tradePeriod               / TP22 /
  i_reserveClass              / FIR, SIR, LIR /
  i_energyOfferComponent      / i_generationMWoffer, i_generationMWofferPrice /
  i_PLSRofferComponent        / i_PLSRofferPercentage, i_PLSRofferMax, i_PLSRofferPrice /
  i_TWDRofferComponent        / i_TWDRofferMax, i_TWDRofferPrice /
  i_ILRofferComponent         / i_ILRofferMax, i_ILRofferPrice /
  i_energyBidComponent        / i_bidMW, i_bidPrice /
  i_ILRbidComponent           / i_ILRbidMax, i_ILRbidPrice /
;

* Call the GDX routine and load the input data:
$gdxin '%system.fp%..\Input\FP_20170213_F.gdx'
* Sets
* Hard-coded sets. Although these 22 sets exist in the vSPD input GDX file, they are not loaded from
* the GDX file. Rather, all but caseName are initialsed via hard-coding in vSPDsolve.gms prior to data
* being loaded from the GDX file. They are declared now because they're used in the domain of other symbols.
$load caseName i_island i_tradeBlock i_CVP i_offerType i_offerParam
$load i_riskClass i_reserveType i_riskParameter i_branchParameter
$load i_lossSegment i_lossParameter i_constraintRHS i_flowDirection
$load i_riskGroup
* fundamental sets - membership is assigned when symbols are loaded from the GDX file in vSPDsolve.gms
*$load i_tradePeriod
$load i_dateTime i_node i_offer i_trader i_bid i_bus i_branch
$load i_branchConstraint i_MnodeConstraint
* multi-dimensional sets, subsets, and mapping sets - membership is populated via loading from GDX file in vSPDsolve.gms
$load i_dateTimeTradePeriodMap i_tradePeriodNode i_tradePeriodOfferNode
$load i_tradePeriodOfferTrader i_tradePeriodBidNode i_tradePeriodBidTrader
$load i_tradePeriodBus i_tradePeriodNodeBus i_tradePeriodBusIsland
$load i_tradePeriodBranchDefn i_tradePeriodRiskGenerator
$load i_tradePeriodPrimarySecondaryOffer i_tradePeriodDispatchableBid
$load i_tradePeriodRiskGroup
*Parameters
* 6 scalars - values are loaded from GDX file in vSPDsolve.gms
$load i_day i_month i_year i_tradingPeriodLength
* 49 parameters - values are loaded from GDX file in vSPDsolve.gms
$load i_StudyTradePeriod i_CVPvalues
* Offer data
$load i_tradePeriodOfferParameter i_tradePeriodEnergyOffer
$load i_tradePeriodSustainedPLSRoffer i_tradePeriodFastPLSRoffer
$load i_tradePeriodSustainedTWDRoffer i_tradePeriodFastTWDRoffer
$load i_tradePeriodSustainedILRoffer i_tradePeriodFastILRoffer
* Demand & bid data
$load i_tradePeriodNodeDemand i_tradePeriodEnergyBid
* Network data
$load i_tradePeriodHVDCNode i_tradePeriodReferenceNode
$load i_tradePeriodHVDCBranch i_tradePeriodBranchParameter
$load i_tradePeriodBranchCapacity i_tradePeriodBranchOpenStatus
$load i_noLossBranch i_AClossBranch i_HVDClossBranch
$load i_tradePeriodNodeBusAllocationFactor i_tradePeriodBusElectricalIsland
* Risk/Reserve data
$load i_tradePeriodRiskParameter i_tradePeriodManualRisk
* Branch constraint data
$load i_tradePeriodBranchConstraintFactors i_tradePeriodBranchConstraintRHS
* Market node constraint data
$load i_tradePeriodMNodeEnergyOfferConstraintFactors
$load i_tradePeriodMNodeReserveOfferConstraintFactors
$load i_tradePeriodMNodeEnergyBidConstraintFactors
$load i_tradePeriodMNodeConstraintRHS
* 11 parameters loaded from GDX with conditional load statement at execution time
$load i_tradePeriodAllowHVDCRoundpower i_tradePeriodManualRisk_ECE
$load i_tradePeriodHVDCSecRiskEnabled i_tradePeriodHVDCSecRiskSubtractor
$load i_tradePeriodReserveClassGenerationMaximum
* Virtual reserve
$load i_tradePeriodVROfferMax i_tradePeriodVROfferPrice
* Scarcity pricing
$load i_tradePeriodScarcitySituationExists
$load i_tradePeriodGWAPFloor i_tradePeriodGWAPCeiling
$load i_tradePeriodGWAPPastDaysAvg i_tradePeriodGWAPCountForAvg
$load i_tradePeriodGWAPThreshold
* NMIR
$load i_tradePeriodReserveRoundPower i_tradePeriodReserveSharing
$load i_tradePeriodModulationRisk i_tradePeriodRoundPower2Mono
$load i_tradePeriodBipole2Mono i_tradePeriodReserveSharingPoleMin
$load i_tradePeriodHVDCcontrolBand i_tradePeriodHVDClossScalingFactor
$load i_tradePeriodSharedNFRfactor i_tradePeriodSharedNFRLoadOffset
$load i_tradePeriodReserveEffectiveFactor
$load i_tradePeriodRMTreserveLimit i_tradePeriodRampingConstraint
$gdxin


*==== PROCESSING DATA ==========================================================
*$ontext

* New reserve offer data
i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt)
    = max( i_tradePeriodFastPLSRoffer(tp,o,trdBlk,PLSofrCmpnt),
           i_tradePeriodSustainedPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ) ;

i_tradePeriodPLSRfactor(tp,o,resC)
   $ { (ord(resC) = 1) and
       sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
           , i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ] }
    = sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
         , i_tradePeriodFastPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ]
    / sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
         , i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ] ;

i_tradePeriodPLSRfactor(tp,o,resC)
    $ { (ord(resC) = 2) and
       sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
           , i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ] }
    = sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
         , i_tradePeriodSustainedPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ]
    / sum[ (trdBlk,PLSofrCmpnt) $ ( ord(PLSofrCmpnt) = 2 )
           , i_tradePeriodPLSRoffer(tp,o,trdBlk,PLSofrCmpnt) ] ;

i_tradePeriodPLSRfactor(tp,o,resC) $ (ord(resC) = 3)
    = 1 $ sum[ resC1, i_tradePeriodPLSRfactor(tp,o,resC1) ] ;


i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt)
    = max( i_tradePeriodFastTWDRoffer(tp,o,trdBlk,TWDofrCmpnt),
           i_tradePeriodSustainedTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ) ;

i_tradePeriodTWDRfactor(tp,o,resC)
   $ { (ord(resC) = 1) and
       sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
         , i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ] }
    = sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
         , i_tradePeriodFastTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ]
    / sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
         , i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ] ;

i_tradePeriodTWDRfactor(tp,o,resC)
    $ { (ord(resC) = 2) and
       sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
         , i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ] }
    = sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
         , i_tradePeriodSustainedTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ]
    / sum[ (trdBlk,TWDofrCmpnt) $ ( ord(TWDofrCmpnt) = 1 )
           , i_tradePeriodTWDRoffer(tp,o,trdBlk,TWDofrCmpnt) ];

i_tradePeriodTWDRfactor(tp,o,resC) $ (ord(resC) = 3) = 1
    = 1 $ sum[ resC1, i_tradePeriodTWDRfactor(tp,o,resC1) ] ;

i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt)
    = max( i_tradePeriodFastILRoffer(tp,o,trdBlk,ILofrCmpnt),
           i_tradePeriodSustainedILRoffer(tp,o,trdBlk,ILofrCmpnt)
         ) ;

i_tradePeriodILRfactor(tp,o,resC)
    $ { (ord(resC) = 1) and
        sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
           , i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt) ] }
    = sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
         , i_tradePeriodFastILRoffer(tp,o,trdBlk,ILofrCmpnt) ]
    / sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
           , i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt) ] ;

i_tradePeriodILRfactor(tp,o,resC)
    $ { (ord(resC) = 2) and
        sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
           , i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt) ] }
    = sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
         , i_tradePeriodSustainedILRoffer(tp,o,trdBlk,ILofrCmpnt) ]
    / sum[ (trdBlk,ILofrCmpnt) $ ( ord(ILofrCmpnt) = 1 )
           , i_tradePeriodILRoffer(tp,o,trdBlk,ILofrCmpnt) ];

i_tradePeriodILRfactor(tp,o,resC) $ (ord(resC) = 3)
    = 1 $ sum[ resC1, i_tradePeriodILRfactor(tp,o,resC1) ] ;

*$offtext

* Test - marginally increase FIR net free reserve by 0.01 MW
i_tradePeriodRiskParameter(tp,'NI','FIR',riskC,'i_FreeReserve')
    = i_tradePeriodRiskParameter(tp,'NI','FIR',riskC,'i_FreeReserve') + 0.01 ;


*===============================================================================

execute_unload '%system.fp%..\Input\NMIR_TP22_NI_FIR_NFR_up10kw.gdx'
* fundamental sets - membership is assigned when symbols are loaded from the GDX file in vSPDsolve.gms
  i_dateTime, i_tradePeriod, i_node, i_offer, i_trader, i_bid, i_bus, i_branch
  i_branchConstraint, i_MnodeConstraint, i_riskGroup
* multi-dimensional sets, subsets, and mapping sets - membership is populated via loading from GDX file in vSPDsolve.gms
  i_dateTimeTradePeriodMap, i_tradePeriodNode, i_tradePeriodOfferNode
  i_tradePeriodOfferTrader, i_tradePeriodBidNode, i_tradePeriodBidTrader
  i_tradePeriodBus, i_tradePeriodNodeBus, i_tradePeriodBusIsland
  i_tradePeriodBranchDefn, i_tradePeriodRiskGenerator
  i_tradePeriodPrimarySecondaryOffer, i_tradePeriodDispatchableBid
  i_tradePeriodRiskGroup
*Parameters
* 6 scalars - values are loaded from GDX file in vSPDsolve.gms
  i_day, i_month, i_year, i_tradingPeriodLength
* 49 parameters - values are loaded from GDX file in vSPDsolve.gms
  i_StudyTradePeriod, i_CVPvalues
* Offer data
  i_tradePeriodOfferParameter, i_tradePeriodEnergyOffer
* New reserve offer data
  i_tradePeriodPLSRoffer, i_tradePeriodPLSRfactor
  i_tradePeriodTWDRoffer, i_tradePeriodTWDRfactor
  i_tradePeriodILRoffer, i_tradePeriodILRfactor
* Demand & bid data
  i_tradePeriodNodeDemand, i_tradePeriodEnergyBid
* Network data
  i_tradePeriodHVDCNode, i_tradePeriodReferenceNode
  i_tradePeriodHVDCBranch, i_tradePeriodBranchParameter
  i_tradePeriodBranchCapacity, i_tradePeriodBranchOpenStatus
  i_noLossBranch, i_AClossBranch, i_HVDClossBranch
  i_tradePeriodNodeBusAllocationFactor, i_tradePeriodBusElectricalIsland
* Risk/Reserve data
  i_tradePeriodRiskParameter, i_tradePeriodManualRisk
* Branch constraint data
  i_tradePeriodBranchConstraintFactors, i_tradePeriodBranchConstraintRHS
* Market node constraint data
  i_tradePeriodMNodeEnergyOfferConstraintFactors
  i_tradePeriodMNodeReserveOfferConstraintFactors
  i_tradePeriodMNodeEnergyBidConstraintFactors
  i_tradePeriodMNodeConstraintRHS
* 11 parameters loaded from GDX with conditional load statement at execution time
  i_tradePeriodAllowHVDCRoundpower, i_tradePeriodManualRisk_ECE
  i_tradePeriodHVDCSecRiskEnabled, i_tradePeriodHVDCSecRiskSubtractor
  i_tradePeriodReserveClassGenerationMaximum
* Virtual reserve
  i_tradePeriodVROfferMax, i_tradePeriodVROfferPrice
* Scarcity pricing
  i_tradePeriodScarcitySituationExists
  i_tradePeriodGWAPFloor, i_tradePeriodGWAPCeiling
  i_tradePeriodGWAPPastDaysAvg, i_tradePeriodGWAPCountForAvg
  i_tradePeriodGWAPThreshold
* MNMIR
  i_tradePeriodReserveRoundPower, i_tradePeriodReserveSharing
  i_tradePeriodModulationRisk, i_tradePeriodRoundPower2Mono
  i_tradePeriodBipole2Mono, i_tradePeriodReserveSharingPoleMin
  i_tradePeriodHVDCcontrolBand, i_tradePeriodHVDClossScalingFactor
  i_tradePeriodSharedNFRfactor, i_tradePeriodSharedNFRLoadOffset
  i_tradePeriodReserveEffectiveFactor
  i_tradePeriodRMTreserveLimit, i_tradePeriodRampingConstraint


  ;
