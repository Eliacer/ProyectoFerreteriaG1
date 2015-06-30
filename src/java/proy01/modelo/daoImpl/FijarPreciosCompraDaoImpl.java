/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.daoImpl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import proy01.modelo.conexion.ConectarOracle;
import proy01.modelo.dao.FijarPreciosCompraDao;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.DetalleCompra;
import proy01.modelo.entidad.KardexProducto;
import proy01.modelo.entidad.Producto;

/**
 *
 * @author Eliacer Fernandez
 */
public class FijarPreciosCompraDaoImpl implements FijarPreciosCompraDao{

    public Connection open(){
        return ConectarOracle.conectar();
    }
    
    @Override
    public List<Compra> ListarComprasNoFijadasPrecios() {
        
        List<Compra> lista = new ArrayList<Compra>();
        Statement st = null;
        ResultSet rs = null;
        Compra compra = null;
        String query = "select id_compra,to_char(fecha_compra,'dd/mm/yyyy') as fc,nombre_comp(id_comprobante) as comp, "
                    + "num_comprobante,nombre_proveedor(id_proveedor) as prov,nombre_forma_pago(id_forma_pago) as fp, "
                    + "precio_fijado from compra where precio_fijado='0'";   
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                compra = new Compra();
                compra.setId_compra(rs.getString("id_compra"));
                compra.setFechaCompra(rs.getString("fc"));
                compra.setId_comprobante(rs.getString("comp"));
                compra.setNumComprobante(rs.getString("num_comprobante"));           
                compra.setId_proveedor(rs.getString("prov"));
                compra.setId_formaPago(rs.getString("fp"));           
                compra.setPrecio_fijado(rs.getString("precio_fijado"));
                
                lista.add(compra);      
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return lista;
    }
    
    @Override
    public List<DetalleCompra> ListarCompraPrecioSugerido(String id_compra) {
        
        List<DetalleCompra> lista = new ArrayList<DetalleCompra>();
        Statement st = null;
        ResultSet rs = null;
        DetalleCompra compra = null;
        String query = "select cd.id_compra,cd.id_producto,nombre_producto(cd.id_producto) as producto,round(cd.costo_und,2) as costo, "
                    + "round(costo_producto(cd.id_producto,cd.id_compra)+(costo_producto(cd.id_producto,cd.id_compra)*(porc_gan(cd.id_producto)/100)),2) as psugerido, "
                    + "cd.pf,round(precio_producto(cd.id_producto),2) as pr,abrev_moneda(c.id_moneda) as abrev "
                    + "from compra_detalle cd,compra c "
                    + "where c.id_compra=cd.id_compra and cd.id_compra='"+id_compra+"'";   
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                compra = new DetalleCompra();
                compra.setId_compra(rs.getString("id_compra"));
                compra.setId_producto(rs.getString("id_producto"));
                compra.setCostoUnidad(rs.getDouble("costo"));
                compra.setProducto(rs.getString("producto"));           
                compra.setPsugerido(rs.getDouble("psugerido"));
                compra.setPf(rs.getString("pf"));
                compra.setPrecio(rs.getString("pr"));
                compra.setAbrev(rs.getString("abrev"));
                lista.add(compra);      
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return lista;
    }

    @Override
    public boolean UpdateProdPrecio(Producto producto) {
        
        boolean estado = false;
        Statement st = null;
        String query = "update producto set "
                +"precio="+producto.getPrecio()
                +" where id_producto='"+producto.getIdProducto()+"'";
       
        try {
            st = open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado=false;
            } catch (Exception ex) {
            }
        }       
        return estado;
    }

    @Override
    public boolean UpdatePrecio(String id_compra) {
        
         boolean estado = false;
        Statement st = null;
        String query = "update compra set "
                    +"precio_fijado='1', fecha_asig=sysdate where id_compra='"+id_compra+"'";
       
        try {
            st = open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado=false;
            } catch (Exception ex) {
            }
        }
        
        return estado;
    }

    @Override
    public boolean Updatedetapf(String id_compra, String id_producto) {
        
        boolean estado = false;
        Statement st = null;
        String query = "update compra_detalle set "
                      +"pf='1' where id_compra='"+id_compra+"' and id_producto='"+id_producto+"'";
       
        try {
            st = open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado=false;
            } catch (Exception ex) {
            }
        }       
        return estado;
    }

    @Override
    public List<KardexProducto> Kardexproducto(String id_producto) {
        
        List<KardexProducto> lista = new ArrayList<KardexProducto>();
        Statement st = null;
        ResultSet rs = null;
        KardexProducto kardexProducto = null;
        String query = "select * from ( "
                + "select p.id_producto as id_producto,c.id_compra as id_movimiento,to_char(c.fecha_compra,'dd-mm-yyyy') as fecha, c.fecha_compra as fech, "
                + "decode(c.e_s,'E','Compra','Venta') as movimiento,p.nombre as producto,cd.cant_total as cantidad, "
                + "und_producto(cd.id_compra,cd.id_producto) as und,nombre_comp(c.id_comprobante) as comprobante, "
                + "c.num_comprobante,nombre_proveedor(c.id_proveedor) as proveedor_cliente from compra_detalle cd "
                + "inner join producto p on p.id_producto=cd.id_producto and p.id_producto='"+id_producto+"' "
                + "inner join compra c on c.id_compra=cd.id_compra "
                + "union "
                + "select pr.id_producto as id_producto,v.id_venta as id_movimiento,to_char(v.fecha_venta,'dd-mm-yyyy') as fecha, v.fecha_venta as fech, "
                + "decode(v.e_s,'S','Venta','Compra') as movimiento,pr.nombre as producto,vd.cantidad as cantidad, "
                + "und_producto_venta(pr.id_unidad_medida) as und,nombre_comp_venta(id_configuracion) as comprobante, "
                + "serieventa(v.id_configuracion)||'-'||v.num_comprobante as num_comprobante, "
                + "nombre_cliente(v.id_cliente) as proveedor_cliente from venta_detalle vd "
                + "inner join producto pr on pr.id_producto=vd.id_producto and pr.id_producto='"+id_producto+"' "
                + "inner join venta v on v.id_venta=vd.id_venta) "
                + "order by fech asc"; 
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                kardexProducto = new KardexProducto();
                kardexProducto.setFecha(rs.getString("fecha"));
                kardexProducto.setMovimiento(rs.getString("movimiento"));
                kardexProducto.setProducto(rs.getString("producto"));
                kardexProducto.setCantidad(rs.getInt("cantidad"));           
                kardexProducto.setUnd(rs.getString("und"));
                kardexProducto.setComprobante(rs.getString("comprobante"));           
                kardexProducto.setNum_comp(rs.getString("num_comprobante"));
                kardexProducto.setProv_cliente(rs.getString("proveedor_cliente"));
                
                lista.add(kardexProducto);      
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return lista;
    }
}
