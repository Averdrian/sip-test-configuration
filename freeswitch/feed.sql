  -- insert two carriers
  INSERT INTO carriers (id, carrier_name, enabled) VALUES (1, 'carrier1', 1);
  INSERT INTO carriers (id, carrier_name, enabled) VALUES (2, 'carrier2', 1);

  -- insert some gateway info
  INSERT INTO carrier_gateway (id, carrier_id, prefix, suffix, codec) VALUES (1, 1, 'sofia/gateway/carrier1/', '@proxy.carrier2.net:5060', '000');
  INSERT INTO carrier_gateway (id, carrier_id, prefix, suffix, codec) VALUES (2, 2, 'sofia/external/', '@proxy.carrier2.net:5060', '000');

  -- insert some lcr data
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (1, '1', 0.15, 1, 0, 0, , , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (2, '1', 0.12, 2, 1, 0, '0', , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (3, '1234', 0.05, 1, 0, 0, , , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (4, '1234', 0.02, 2, 1, 0, '0', , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);


  INSERT INTO lcr (id, digits, rate, intrastate_rate, intralata_rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
  VALUES          (1, '1', 0.15,0.15,0.15, 1, 0, 0, 'prefix', 'suffix', current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (2, '1', 0.12, 2, 1, 0, '0', , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (3, '1234', 0.05, 1, 0, 0, , , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);
--   INSERT INTO lcr (id, digits, rate, carrier_id, lead_strip, trail_strip, prefix, suffix, date_start, date_end, quality, reliability)
--   VALUES (4, '1234', 0.02, 2, 1, 0, '0', , current_timestamp - interval 1 year, current_timestamp + interval 1 year , 0, 0);


