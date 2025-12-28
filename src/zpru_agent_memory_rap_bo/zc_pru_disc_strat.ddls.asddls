@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZPRU_DISC_STRAT'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PRU_DISC_STRAT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_PRU_DISC_STRAT
  association [1..1] to ZR_PRU_DISC_STRAT as _BaseEntity on $projection.DISCARDSTRATEGY = _BaseEntity.DISCARDSTRATEGY
{
  key DiscardStrategy,
  StrategyProvider,
  CreatedBy,
  CreatedAt,
  ChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChanged,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChanged,
  _BaseEntity
}
