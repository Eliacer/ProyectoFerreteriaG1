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
                    + "precio_fijado from compra ";   
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
        String query = "select id_compra,id_producto,nombre_producto(id_producto) as producto,round(costo_und,2) as costo, "
                    + "round(costo_und+((porc_gan(id_producto)/100)*costo_und),2) as psugerido, "
                    + "pf,round(precio_producto(id_producto),2) as pr from compra_detalle where id_compra='"+id_compra+"'";   
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
}
