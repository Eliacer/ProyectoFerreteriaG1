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
import proy01.modelo.dao.CompraDao;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.Comprobante;
import proy01.modelo.entidad.FormaPago;
import proy01.modelo.entidad.TipoMoneda;

/**
 *
 * @author Eliacer Fernandez
 */
public class CompraDaoImpl implements CompraDao{

    public Connection open(){
        
        return ConectarOracle.conectar();
    }
    
    @Override
    public List<Comprobante> ListarComprobante() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_comprobante,initcap(nombre) as nombre from comprobante ";
        List<Comprobante> lista = new ArrayList<Comprobante>();
        Comprobante comp= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                comp = new Comprobante();              
                comp.setIdComprobante(rs.getString("id_comprobante"));
                comp.setNombreComprobante(rs.getString("nombre"));           
                lista.add(comp);   
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
    public List<FormaPago> ListarFormapago() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_forma_pago,initcap(nombre) as nombre from forma_pago ";
        List<FormaPago> lista = new ArrayList<FormaPago>();
        FormaPago tp= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                tp = new FormaPago();              
                tp.setIdFormaPago(rs.getString("id_forma_pago"));
                tp.setNombre(rs.getString("nombre"));           
                lista.add(tp);   
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
    public List<TipoMoneda> ListarMoneda() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_moneda,initcap(nombre) as nombre, valor_actual from tipo_moneda ";
        List<TipoMoneda> lista = new ArrayList<TipoMoneda>();
        TipoMoneda tm= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                tm = new TipoMoneda();              
                tm.setIdMoneda(rs.getString("id_moneda"));
                tm.setNombre(rs.getString("nombre")); 
                tm.setValorActual(rs.getDouble("valor_actual"));
                lista.add(tm);   
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
    public Compra ListarCompra(String num_com) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from compra where num_comprobante='"+num_com+"' ";
        Compra compra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                compra = new Compra();              
                compra.setId_compra(rs.getString("id_compra"));
                compra.setId_usuario(rs.getString("id_usuario")); 
                compra.setId_proveedor(rs.getString("id_proveedor"));   
                compra.setId_tipoMoneda(rs.getString("id_tipo_moneda")); 
                compra.setId_comprobante(rs.getString("id_comprobante")); 
                compra.setNumComprobante(rs.getString("num_comprobante")); 
                compra.setId_formaPago(rs.getString("id_forma_pago")); 
                compra.setFechaCompra(rs.getString("fecha_compra"));
                compra.setDescripcion(rs.getString("descripcion"));
                compra.setIgv(rs.getString("igv"));
                compra.setFlete(rs.getString("flete"));     
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return compra; 
    
    }

    @Override
    public boolean RegistrarCompra(Compra compra) {
        
        boolean estado = false;
        Statement st = null;
        String query="insert into compra "
                    + "(id_usuario, "
                    + "id_proveedor, "
                    + "id_moneda, "
                    + "id_comprobante, "
                    + "num_comprobante, "
                    + "id_forma_pago, "
                    + "fecha_compra, "
                    + "descripcion, "
                    + "igv, "
                    + "flete) "
                    + "values('"+compra.getId_usuario()+"',"
                    + "'"+compra.getId_proveedor()+"',"
                    + "'"+compra.getId_tipoMoneda()+"',"
                    + "'"+compra.getId_comprobante()+"',"
                    + "'"+compra.getNumComprobante()+"',"
                    + "'"+compra.getId_formaPago()+"',"
                    + " to_date('"+compra.getFechaCompra()+"','yyyy-mm-dd'),"
                    + "'"+compra.getDescripcion()+"',"
                    + ""+Double.parseDouble(compra.getIgv())+","
                    + ""+Double.parseDouble(compra.getFlete())+")";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
        return estado;
    }

    @Override
    public List<Compra> ListarCompraT() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select c.id_compra as id,nombre(u.id_usuario) as user,per.nombre as prov,m.nombre as money, co.nombre as comp "
                + "c.num_comprobante as num_comp,fp.nombre as fpago,c.fecha_compra as date,c.descripcion as desc,c.igv as igv, c.flete as flete "
                + "from persona per, usuario u, proveedor p, comprobante co, tipo_modena tm,forma_pago fp, compra c "
                + "where per.id_persona=p.id_proveedor and u.id_usuario=c.id_usuario and p.id_proveedor=c.id_proveedor "
                + "and tm.id_moneda=c.id_moneda and co.id_comprobante=c.id_comprobante and fp.id_forma_pago=c.id_forma_pago ";
        List<Compra> lista = new ArrayList<Compra>();
        Compra compra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                compra = new Compra();              
                compra.setId_compra(rs.getString("id"));
                compra.setId_usuario(rs.getString("user")); 
                compra.setId_proveedor(rs.getString("prov"));   
                compra.setId_tipoMoneda(rs.getString("money")); 
                compra.setId_comprobante(rs.getString("comp")); 
                compra.setNumComprobante(rs.getString("num_comp")); 
                compra.setId_formaPago(rs.getString("fpago")); 
                compra.setFechaCompra(rs.getString("date"));
                compra.setDescripcion(rs.getString("desc"));
                compra.setIgv(rs.getString("igv"));
                compra.setFlete(rs.getString("flete"));   
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
    
}
