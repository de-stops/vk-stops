CREATE TEMPORARY TABLE STOPS (stop_id varchar, stop_name varchar, stop_lon double precision, stop_lat double precision, stop_code varchar);

COPY
	STOPS
FROM
	:stops_input
	DELIMITER ','
	CSV
		HEADER
		QUOTE '"';

CREATE TEMPORARY TABLE GEMEINDEN (wkt_geom varchar, ADE varchar, GF varchar, BSG varchar, RS varchar, AGS varchar, SDV_RS varchar, GEN varchar, BEZ varchar, IBZ varchar, BEM varchar, NBD varchar, SN_L varchar, SN_R varchar, SN_K varchar, SN_V1 varchar, SN_V2 varchar, SN_G varchar, FK_S3 varchar, NUTS varchar, RS_0 varchar, AGS_0 varchar, WSK varchar, DEBKG_ID varchar);

COPY
	GEMEINDEN
FROM
	:gemeinden_input
	DELIMITER E'\t'
	CSV
		HEADER;


COPY (
	select
		stops.*
	from
		stops,
		gemeinden,
		vg250_gem
	where
		ST_contains(vg250_gem.geom, ST_SetSRID(ST_MakePoint(stops.stop_lon, stops.stop_lat), 4326)) and
		vg250_gem.rs = gemeinden.rs
)
TO
	:stops_output
WITH
	CSV
	HEADER QUOTE '"'
	FORCE QUOTE stop_id, stop_name, stop_code;
