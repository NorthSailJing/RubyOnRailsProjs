CREATE OR REPLACE FUNCTION fn_pin_generate(_pin_list_id int, _pin_num int)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
 DECLARE _pin_count int := 0;
 DECLARE _pin_char_set varchar(50) := '3479ACEFHJKMNPQRTWXY';
 DECLARE _pin varchar(10);
 DECLARE _pin_length int := 8;
BEGIN	
	IF _pin_list_id IS NULL THEN
		RETURN 'Please privide a pin_list_id.';
	END IF;

	IF _pin_num <= 0 THEN
		RETURN 'Please privide a valid pin number.';
	END IF;
	
	WHILE _pin_count < _pin_num LOOP
		SELECT STRING_AGG(c, '') 
		FROM (
		SELECT c FROM REGEXP_SPLIT_TO_TABLE(_pin_char_set, '') AS c
		ORDER BY RANDOM()
		LIMIT _pin_length	
		) AS tmp INTO _pin;
	
		IF EXISTS(SELECT * FROM pins WHERE pin_list_id = _pin_list_id AND pin = _pin) THEN
			CONTINUE;
		END IF;
	
		INSERT INTO pins(pin_list_id, pin) VALUES(_pin_list_id, _pin);
		
		_pin_count := _pin_count + 1;
	
	END LOOP;	
	
	RETURN _pin_count || ' pins have been generated.';

END;
$function$
;

-- SELECT fn_pin_generate(1, 10000);