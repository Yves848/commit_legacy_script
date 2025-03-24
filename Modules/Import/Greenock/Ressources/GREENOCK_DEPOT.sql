SELECT 
  wl.WhID
 ,wl.WarehouseLabel
 ,w.RobotType
FROM Article.Warehouses w
inner join Article.WarehouseLabels wl on w.WhID = wl.WhID
where wl.LangCode='*'
order by w.DelivSortNr