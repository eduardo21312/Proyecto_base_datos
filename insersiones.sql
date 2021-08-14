
insert into CLIENTE values('TOGE100853','Torres','Guitierrez','Erendira','Rio Nativitas',4,'Presidentes de Mexico',09770,'CDMX');
insert into CLIENTE values('MASG730516','Martinez','Solano','Genaro','Rio Nazas',62,'Puente Blanco',09740,'CDMX');



insert into VENTA(fecha_venta,rfc_cliente) values('2021/08/12','TOGE100853');
insert into VENTA(fecha_venta,rfc_cliente) values('2021/08/13','MASG730516');
insert into VENTA(fecha_venta,rfc_cliente) values('2021/08/12','TOGE100853');
insert into VENTA(fecha_venta,rfc_cliente) values('2023/08/13','MASG730516');




insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(1,1,150.50,50,20);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(2,3,75.50,20,5);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(1,2,35.80,35,15);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(2,5,65.79,14,5);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(1,4,200.45,85,50);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(2,7,96.35,10,3);
insert into DETALLE_VENTA(num_venta,id_producto,precio_producto,canticad_producto,venta_total) values(1,6,3.50,9,2);
