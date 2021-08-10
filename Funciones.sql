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

//se crea  el trigger por si haceel borrado
CREATE TRIGGER trigger_borrar_detalle_venta
after delete
ON DETALLE_VENTA
FOR EACH ROW
EXECUTE PROCEDURE funcion_verificar_borrado_detalle_venta();


--FUNCIONES EDUARDO
-- igual verificamos la tabla orden_detalle como su primarykey es identity volvemos actualizar su id EDUARDO
CREATE OR REPLACE FUNCTION funcion_verificar_borrado_detalle_venta()
RETURNS trigger AS
$$
declare variable_funcion int;
begin
if(exists(select num_venta from DETALLE_VENTA)) then
select (max(num_venta)+1) from DETALLE_VENTA into variable_funcion;
execute 'alter SEQUENCE detalle_venta_numero  RESTART with '|| variable_funcion;
return new;
else
execute 'alter SEQUENCE detalle_venta_numero RESTART with '|| 1;
return new;
end if;
END;
$$
LANGUAGE plpgsql;



--se hace una funcion vista para cada orden de producto como hay ordenes con diferentes producto aqui arroja todos los productos que se estan
--vendiendo EDUARDO
CREATE OR REPLACE FUNCTION venta_ticket(orden_del_cliente VARCHAR(8))
RETURNS  table(
               num_venta int,
               fecha_venta date,
               nombre VARCHAR(60),
               descripcion varchar(100),
               marca varchar(60),
               cantidad_producto int,
               precio_producto decimal(6,2),
               venta_total decimal(7,2)) AS
$$
begin
return query (select v.nota,v.fecha_venta,concat(c.nombre,' ',c.apellido_paterno,' ',c.apellido_materno),
              p.descripcion,p.marca,dv.cantidad_producto,dv.precio_producto,dv.venta_total
              from VENTA as v inner join
              DETALLE_VENTA  as dv on v.num_venta=dv.num_venta
              inner join CLIENTE as c on c.razon_cliente=v.razon_cliente
              inner join PRODUCTO as p on p.id_producto=dv.id_producto
              where v.nota=orden_del_cliente);
END;
$$
LANGUAGE plpgsql;
