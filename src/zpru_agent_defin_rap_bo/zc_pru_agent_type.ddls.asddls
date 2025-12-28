@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPRU_AGENT_TYPE'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PRU_AGENT_TYPE
  provider contract transactional_query
  as projection on ZR_PRU_AGENT_TYPE
  association [1..1] to ZR_PRU_AGENT_TYPE as _BaseEntity on $projection.AgentType = _BaseEntity.AgentType
{
  key AgentType,
  ShortMemVolume,
  DiscardStrategy,
  SummaryStrategy,
  MaxNumbLoop,
  CreatedBy,
  CreatedAt,
  ChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChanged,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChanged,
  _BaseEntity
}
