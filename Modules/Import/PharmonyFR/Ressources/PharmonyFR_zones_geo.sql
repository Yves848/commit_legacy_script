select  
	loc.id geo_id,
	loc.name geo_name,
	dep."name" dep_name,
	dep.id dep_id,
	case 
    when dep.robot = 'false' then '0'
    when dep.robot = 'true' then '1'
	else
	  '0'
	end
	 dep_robot 
from storage_locations loc
left join storage_spaces dep on loc.storage_space_id = dep.id