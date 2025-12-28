@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPRU_DISC_STRAT'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PRU_DISC_STRAT 
  as select from zpru_disc_strat
{
  key discard_strategy as DiscardStrategy,
  strategy_provider as StrategyProvider,
  created_by as CreatedBy,
  created_at as CreatedAt,
  changed_by as ChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed as LastChanged,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
}
