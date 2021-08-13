// igual verificamos la tabla orden_detalle como su primarykey es identity volvemos actualizar su id EDUARDO
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

//creamos al trigger por si borra la tabla detalle_venta
CREATE TRIGGER trigger_borrado_detalle_venta
after delete
ON DETALLE_VENTA
FOR EACH ROW
EXECUTE PROCEDURE funcion_verificar_borrado_detalle_venta();


//se hace una funcion vista para cada orden de producto como hay ordenes con diferentes producto aqui arroja todos los productos que se estan
//vendiendo EDUARDO
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
