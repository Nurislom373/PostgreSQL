with charge_box_connectors as (select distinct c.charge_box_id     as chargeBoxId,
                                               c.connector_id      as connectorId,
                                               c.connector_type_id as connectorTypeId,
                                               i.url               as imageUrl
                               from connector c
                                        left join rel_connector_type__logo rctl
                                             on c.connector_type_id = rctl.connector_type_id
                                        left join image i on i.id = rctl.logo_id),
     charge_box_image as (select i.name as name,
                                 i.url  as url,
                                 b.id   as chargeBoxId
                          from image i
                                   inner join rel_charge_box_info__logo r on i.id = r.logo_id
                                   inner join charge_box_info cbi2 on cbi2.id = r.charge_box_info_id
                                   inner join charge_box b on b.id = cbi2.charge_box_id),
     public_charge_box as (select cb.id                       as id,
                                  cb.status                   as status,
                                  cb.imsi                     as imsi,
                                  cb.last_heartbeat_timestamp as lastHeartbeatTimestamp,
                                  -- chargeBox info
                                  cbi.name                    as chargeBoxInfoName,
                                  cbi.information             as information,
                                  cbi.facilities              as facilities,
                                  cbi.working_hours           as workingHours,
                                  cbi.price                   as price,
                                  -- address
                                  a.name                      as addressName,
                                  a.full_address              as fullAddress,
                                  a.locality                  as locality,
                                  a.country                   as country,
                                  a.area                      as area,
                                  a.province                  as province,
                                  a.district                  as district,
                                  a.street                    as street,
                                  a.other                     as other,
                                  a.metro                     as metro,
                                  a.hydro                     as hydro,
                                  a.vegetation                as vegetation,
                                  a.airport                   as airport,
                                  a.location_latitude         as locationLatitude,
                                  a.location_longitude        as locationLongitude,
                                  -- brand
                                  b.name                      as brandName,
                                  b.phone_support_1           as phoneSupport1,
                                  b.phone_support_2           as phoneSupport2,
                                  b.telegram                  as telegram,
                                  b.phone_boss                as phoneBoss,
                                  b.app_url                   as appUrl,
                                  b.app_store_url             as appStoreUrl,
                                  b.social_networks           as socialNetworks
                           from charge_box cb
                                    left outer join charge_box_info cbi on cb.id = cbi.charge_box_id
                                    left outer join address a on cbi.address_id = a.id
                                    left join brand b on cbi.brand_id = b.id)

select pcb.id, json_agg(cbi) as images, json_agg(cbc) as connectors
from public_charge_box pcb
         left outer join charge_box_connectors cbc on pcb.id = cbc.chargeBoxId
         left outer join charge_box_image cbi on pcb.id = cbi.chargeBoxId
group by pcb.id order by pcb.id;

