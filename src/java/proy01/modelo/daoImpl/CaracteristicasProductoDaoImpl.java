/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.daoImpl;

import proy01.modelo.conexion.ConectarOracle;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import proy01.modelo.dao.CaracteristicasProductoDao;
import proy01.modelo.entidad.Categoria;
import proy01.modelo.entidad.Marca;
import proy01.modelo.entidad.Ubicacion;
import proy01.modelo.entidad.UndMedida;
import proy01.modelo.entidad.Unidad;

/**
 *
 * @author Eliacer Fernandez
 */
public class CaracteristicasProductoDaoImpl implements CaracteristicasProductoDao{

    public Connection open(){
        
        return ConectarOracle.conectar();
    }
    
    @Override
    public List<Marca> ListarMarca() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_marca,initcap(nombre_marca) as nombre,estado from marca where estado='1' "
                + "order by id_marca asc ";
        List<Marca> lista = new ArrayList<Marca>();
        Marca ma= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                ma = new Marca();              
                ma.setIdMarca(rs.getString("id_marca"));
                ma.setNombreMarca(rs.getString("nombre"));
                ma.setEstado(rs.getString("estado"));
                lista.add(ma);   
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
    public List<Categoria> ListarCategoria() {
        
       Statement st=null;
        ResultSet rs=null;
        String sql = "select id_categoria,initcap(nombre_categoria) as nombre,estado from categoria where estado='1' "
                + "order by nombre_categoria asc ";
        List<Categoria> lista = new ArrayList<Categoria>();
        Categoria ca= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                ca = new Categoria();              
                ca.setIdCategoria(rs.getString("id_categoria"));
                ca.setNombreCategoria(rs.getString("nombre"));
                ca.setEstado(rs.getString("estado"));
                lista.add(ca);   
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
    public List<Ubicacion> ListarUbicacion() {
        
       Statement st=null;
        ResultSet rs=null;
        String sql = "select id_ubicacion,initcap(nombre_ubicacion) as nombre,estado from ubicacion where estado='1' "
                + "order by id_ubicacion asc";
        List<Ubicacion> lista = new ArrayList<Ubicacion>();
        Ubicacion ub= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                ub = new Ubicacion();              
                ub.setId_ubicacion(rs.getString("id_ubicacion"));
                ub.setNombre_ubicacion(rs.getString("nombre"));
                ub.setEstado(rs.getString("estado"));
                lista.add(ub);   
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
    public List<UndMedida> ListarUniMedida() {
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_unidad_medida,initcap(nombre_und_medida) as nombre,abreviatura from unidad_medida "
                + "where estado='1' order by nombre asc";
        List<UndMedida> lista = new ArrayList<UndMedida>();
        UndMedida um= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                um = new UndMedida();              
                um.setIdUndMedida(rs.getString("id_unidad_medida"));
                um.setNombre(rs.getString("nombre"));
                um.setAbreviatura(rs.getString("abreviatura"));
                lista.add(um);   
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
    public List<Unidad> ListarUnidad() {
   
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_unidad as id_unidad , initcap(nombre_unidad) as nombre_unidad, abreviatura "
                   + "from unidad ";
        List<Unidad> lista = new ArrayList<Unidad>();
        Unidad um= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                um = new Unidad();              
                um.setId_unidad(rs.getString("id_unidad"));
                um.setNombre_unidad(rs.getString("nombre_unidad"));
                um.setAbrev_unidad(rs.getString("abreviatura"));
                lista.add(um);   
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
    public boolean Add_Caracteristicas (String nombre,String dato) {
        
        boolean estado = false;
        Statement st = null;
        String query="Insert into "+nombre+" values ('','"+dato+"','')";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado = false;          
            } catch (Exception ex) {
            }
        } 
        return estado;
    }

    @Override
    public double GenerarP_Publico(double p_compra, double p_pub, double igv, double flete) {
              
        double p_publico=0;
        
        if(p_compra!=0 && p_pub!=0 ){ 
            p_publico = p_compra+p_compra*(igv/100)+p_compra*(p_pub/100)+p_compra*(flete/100);
        }
           
        return p_publico;
    }

    @Override
    public double GenerarP_Mayor(double p_compra, double p_may, double igv, double flete) {
        double p_mayor=0;
        
        if(p_compra!=0 && p_may!=0 ){ 
            p_mayor = p_compra+p_compra*(igv/100)+p_compra*(p_may/100)+p_compra*(flete/100);
        }
           
        return p_mayor;    
    }

    @Override
    public double GenerarP_Credito(double p_compra, double p_cred, double igv, double flete) {

        double p_credito=0;
        
        if(p_compra!=0 && p_cred!=0 ){ 
            p_credito = p_compra+p_compra*(igv/100)+p_compra*(p_cred/100)+p_compra*(flete/100);
        }
           
        return p_credito;
    }

    

}
