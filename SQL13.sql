""" # 13 for SQL assesment """


select b.name, m.name, m.year, b.discontinued, 
abs(b.discontinued - m.year) as years_until_brand_discontinued
from models as m left join brands as b on m.brand_name=b.name
where b.discontinued is not null order by b.name, m.name, m.year;