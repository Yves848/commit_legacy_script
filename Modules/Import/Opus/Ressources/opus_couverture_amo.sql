select
st.st_code,
trim(st.st_nom),
st.na_code,
st.ju_code,
dcphn.dc_taux phn,
dcph1.dc_taux ph1,
dcph2.dc_taux ph2,
dcph4.dc_taux ph4,
dcph7.dc_taux ph7,
dcaad.dc_taux aad,
dcpmr.dc_taux pmr
from STATUT st
left join DROITCLI dcphn on dcphn.st_code = st.st_code and dcphn.ac_code = 'PHN'
left join DROITCLI dcph1 on dcph1.st_code = st.st_code and dcph1.ac_code = 'PH1'
left join DROITCLI dcph2 on dcph2.st_code = st.st_code and dcph2.ac_code = 'PH2'
left join DROITCLI dcph4 on dcph4.st_code = st.st_code and dcph4.ac_code = 'PH4'
left join DROITCLI dcph7 on dcph7.st_code = st.st_code and dcph7.ac_code = 'PH7'
left join DROITCLI dcaad on dcaad.st_code = st.st_code and dcaad.ac_code = 'AAD'
left join DROITCLI dcpmr on dcpmr.st_code = st.st_code and dcpmr.ac_code = 'PMR'
