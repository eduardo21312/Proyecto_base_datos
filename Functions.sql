-- Función que permite regresar la cantidad vendida de productos entre una fecha de inicio y una fecha final
CREATE OR REPLACE FUNCTION cantidad_vendida_por_fecha(fecha1 varchar(30), fecha2 varchar(30))
RETURNS varchar(70) AS $$
DECLARE 
	cadena varchar(70);
	total numeric(5,0);
BEGIN
	IF fecha2 IS NOT NULL THEN
		IF fecha1 IS NOT NULL THEN
		   SELECT SUM(cantidad_a_pagar) into total FROM VENTA 
		   WHERE fecha_venta IN (CAST (fecha1 as DATE), CAST(fecha2 as DATE));
		   cadena='La cantidad vendida entre'|| '  ' ||fecha1 ||' '|| 'y'
		   || ' ' || fecha2 || ' ' || 'es' || ' '||CAST(total as varchar(6));
		ELSE
			SELECT SUM(cantidad_a_pagar) into total FROM VENTA
		WHERE fecha_venta IN (CAST(fecha2 as DATE));
		cadena='La cantidad vendida el'|| '  ' ||fecha2 ||' '|| 'es' || ' '||CAST(total as varchar(6));
		END IF;
	ELSE
			SELECT SUM(cantidad_a_pagar) into total FROM VENTA
			WHERE fecha_venta IN (CAST(fecha1 as DATE));
			cadena='La cantidad vendida el'|| '  ' ||fecha1 ||' '|| 'es' || ' '||CAST(total as varchar(6));
		
	END IF;
	RETURN cadena;
END;
$$ Language plpgsql;
