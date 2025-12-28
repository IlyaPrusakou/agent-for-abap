@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPRU_SUMM_STRAT'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PRU_SUMM_STRAT
  as select from ZPRU_SUMM_STRAT
{
  key summary_strategy as SummaryStrategy,
  strategy_provider as StrategyProvider,
  created_by as CreatedBy,
  created_at as CreatedAt,
  changed_by as ChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed as LastChanged,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
}
