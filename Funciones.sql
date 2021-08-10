-- Funcion para obtener todo sobre el producto dado un determinado código de barras
CREATE OR REPLACE FUNCTION FUNCION_CODIGO_BARRAS(codigo int)
RETURNS SETOF PRODUCTO AS $$
BEGIN
	RETURN QUERY SELECT * FROM PRODUCTO where codigo_barras=codigo;
END
$$ LANGUAGE plpgsql;


-- Función que reinicia el id_producto
CREATE OR REPLACE FUNCTION reinicia_id_producto()
RETURNS void AS $$
declare id_start int;
BEGIN
	begin
	select max(id_producto)+1 from PRODUCTO into id_start;
	execute 'alter SEQUENCE producto_id_producto_seq  RESTART with '|| 1;
	end;
END
$$ LANGUAGE plpgsql;


-- Funcion que detecta si un código está repetido y luego lo borra
CREATE OR REPLACE FUNCTION verifica_codigo_repetido()
RETURNS trigger AS
$$
declare id_funcion int;
begin
	if exists((SELECT codigo_barras,razon_social FROM PRODUCTO group by codigo_barras,razon_social having count(*)>1))then
		raise notice 'Error al insertar: Ya hay un producto con el mismo codigo de barras y proveedor';
		select (max(id_producto)-1) from PRODUCTO into id_funcion;
		execute 'alter SEQUENCE ciclo_producto_id RESTART with '|| id_funcion;
		delete from PRODUCTO where id_producto=(select (max(id_producto)) from PRODUCTO);
		return new;
	else
		select max(id_producto)+1 from PRODUCTO into id_funcion;
		execute 'alter SEQUENCE ciclo_producto_id RESTART with'|| id_funcion;
		UPDATE PRODUCTO
		set utilidad=(select precio from PRODUCTO group by precio having max(id_producto)=(select max(id_producto) from PRODUCTO))-(select precio_compra from INVENTARIO
			where codigo_barras=(select codigo_barras from PRODUCTO group by codigo_barras having max(id_producto)=(select max(id_producto) from PRODUCTO)))
			where id_producto=(select max(id_producto) from PRODUCTO);
		raise notice 'Inserción exitosa';
		return new;
	end if;
END;
$$
LANGUAGE plpgsql;
