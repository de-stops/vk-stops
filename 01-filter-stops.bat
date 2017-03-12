psql^
 --username=postgres^
 --dbname VG^
 -f 01-filter-stops.sql^
 --set=stops_input="'%cd%\unfiltered-stops.txt'"^
 --set=gemeinden_input="'%cd%\gemeinden.txt'"^
 --set=stops_output="'%cd%\stops.txt'"
