select 
	product,
	lastvente,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[25]/p.upcount else ventes[25] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[26]/p.upcount else ventes[26] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[27]/p.upcount else ventes[27] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[28]/p.upcount else ventes[28] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[29]/p.upcount else ventes[29] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[30]/p.upcount else ventes[30] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[31]/p.upcount else ventes[31] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[32]/p.upcount else ventes[32] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[33]/p.upcount else ventes[33] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[34]/p.upcount else ventes[34] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[35]/p.upcount else ventes[35] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[36]/p.upcount else ventes[36] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[37]/p.upcount else ventes[37] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[38]/p.upcount else ventes[38] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[39]/p.upcount else ventes[39] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[40]/p.upcount else ventes[40] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[41]/p.upcount else ventes[41] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[42]/p.upcount else ventes[42] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[43]/p.upcount else ventes[43] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[44]/p.upcount else ventes[44] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[45]/p.upcount else ventes[45] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[46]/p.upcount else ventes[46] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[47]/p.upcount else ventes[47] end,
	case when (p.fraction = 1 and p.upcount <> 0) then ventes[48]/p.upcount else ventes[48] end
from "LGO2".canal c
left join "LGO2".products p on p.ci = c.product 