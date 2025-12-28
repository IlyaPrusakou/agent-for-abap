@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPRU_AGENT_TYPE'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PRU_AGENT_TYPE
  as select from zpru_agent_type
{
  key agent_type as AgentType,
  short_mem_volume  as ShortMemVolume,
  discard_strategy as DiscardStrategy,
  summary_strategy as SummaryStrategy,
  max_numb_loop as MaxNumbLoop,
  created_by as CreatedBy,
  created_at as CreatedAt,
  changed_by as ChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed as LastChanged,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
}
