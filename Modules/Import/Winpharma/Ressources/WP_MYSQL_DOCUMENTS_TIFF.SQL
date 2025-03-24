select
  i.ti,
  i.skey,
  cast(from_unixtime(i.tmCreate) as date) tmcreate,
  i.blob_ti,
  b.offset,
  b.size_filecode,
  i.tbln
from
  image i
  inner join blobs b on (b.ti = i.blob_ti)  