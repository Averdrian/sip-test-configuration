-- Crear base de datos si no existe
CREATE DATABASE free;

-- Usar la base de datos creada (en PostgreSQL tendrías que conectarte manualmente a la base de datos)
\c free;

-- Eliminar tabla si existe
DROP TABLE IF EXISTS gateways;

-- Crear tabla `gateways`
CREATE TABLE gateways (
   gateway_id SERIAL PRIMARY KEY,
   gateway_ip VARCHAR(16) NOT NULL,
   "group" VARCHAR(15) NOT NULL,
   "limit" INTEGER NOT NULL,
   techprofile VARCHAR(128) NOT NULL
);

-- Insertar datos en `gateways`
INSERT INTO gateways (gateway_ip, "group", "limit", techprofile)
VALUES 
   ('10.22.80.1', 'mustang', 50, 'sofia/default');

-- Eliminar tabla si existe
DROP TABLE IF EXISTS numbers;

-- Crear tabla `numbers`
CREATE TABLE numbers (
   number_id SERIAL PRIMARY KEY,
   gateway_id INTEGER NOT NULL,
   number VARCHAR(16) NOT NULL UNIQUE,
   acctcode VARCHAR(16) NOT NULL,
   translated VARCHAR(16) NOT NULL,
   FOREIGN KEY (gateway_id) REFERENCES gateways (gateway_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insertar datos en `numbers`
INSERT INTO numbers (gateway_id, number, acctcode, translated)
VALUES 
   (1, '19018577141', '999999', '9018577141'),
   (1, '19995551212', '666666', '9995551212');

-- Eliminar tabla si existe
DROP TABLE IF EXISTS carriers;

-- Crear tabla `carriers`
CREATE TABLE carriers (
   id SERIAL PRIMARY KEY,
   carrier_name VARCHAR(255),
   enabled BOOLEAN NOT NULL DEFAULT TRUE
);

-- Eliminar tabla si existe
DROP TABLE IF EXISTS lcr;

-- Crear tabla `lcr`
CREATE TABLE lcr (
   id SERIAL PRIMARY KEY,
   digits VARCHAR(15),
   rate NUMERIC(11,5) NOT NULL,
   intrastate_rate NUMERIC(11,5) NOT NULL,
   intralata_rate NUMERIC(11,5) NOT NULL,
   carrier_id INTEGER NOT NULL,
   lead_strip INTEGER NOT NULL,
   trail_strip INTEGER NOT NULL,
   prefix VARCHAR(16) NOT NULL,
   suffix VARCHAR(16) NOT NULL,
   lcr_profile VARCHAR(32),
   date_start TIMESTAMP NOT NULL DEFAULT '1970-01-01',
   date_end TIMESTAMP NOT NULL DEFAULT '2030-12-31',
   quality NUMERIC(10,6) NOT NULL,
   reliability NUMERIC(10,6) NOT NULL,
   cid VARCHAR(32) NOT NULL DEFAULT '',
   enabled BOOLEAN NOT NULL DEFAULT TRUE,
   FOREIGN KEY (carrier_id) REFERENCES carriers (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear índices adicionales en `lcr`
CREATE INDEX carrier_id_idx ON lcr (carrier_id);
CREATE INDEX digits_idx ON lcr (digits);
CREATE INDEX lcr_profile_idx ON lcr (lcr_profile);
CREATE INDEX rate_idx ON lcr (rate);
CREATE INDEX digits_profile_cid_rate_idx ON lcr (digits, rate);

-- Eliminar tabla si existe
DROP TABLE IF EXISTS npa_nxx_company_ocn;

-- Crear tabla `npa_nxx_company_ocn`
CREATE TABLE npa_nxx_company_ocn (
   npa SMALLINT NOT NULL,
   nxx SMALLINT NOT NULL,
   company_type TEXT,
   ocn TEXT,
   company_name TEXT,
   lata INTEGER,
   ratecenter TEXT,
   state TEXT
);

-- Crear índice único en `npa_nxx_company_ocn`
CREATE UNIQUE INDEX npanxx_idx ON npa_nxx_company_ocn (npa, nxx);

-- Eliminar tabla si existe
DROP TABLE IF EXISTS carrier_gateway;

-- Crear tabla `carrier_gateway`
CREATE TABLE carrier_gateway (
   id SERIAL PRIMARY KEY,
   carrier_id INTEGER REFERENCES carriers (id),
   prefix VARCHAR(255) NOT NULL,
   suffix VARCHAR(255) NOT NULL,
   codec VARCHAR(255) NOT NULL,
   enabled BOOLEAN NOT NULL DEFAULT TRUE
);

-- Crear índice en `carrier_gateway`
CREATE INDEX carrier_id_idx ON carrier_gateway (carrier_id);
