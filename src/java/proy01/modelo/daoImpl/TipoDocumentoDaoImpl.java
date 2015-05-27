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
import proy01.modelo.dao.TipoDocumentoDao;
import proy01.modelo.entidad.Rol;
import proy01.modelo.entidad.TipoDocumento;

/**
 *
 * @author Eliacer Fernandez
 */
public class TipoDocumentoDaoImpl implements TipoDocumentoDao{

    public Connection open(){
        
        return ConectarOracle.conectar();
    }
   
    public List<TipoDocumento> ListarTipoDocumento() {   
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from tipo_documento";
        List<TipoDocumento> lista = new ArrayList<TipoDocumento>();
        TipoDocumento td= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                td = new TipoDocumento();              
                td.setId_tipo_doc(rs.getString("id_tipo_doc"));
                td.setNombre(rs.getString("nombre"));
                lista.add(td);   
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
    public List<Rol> ListarRoles() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from rol";
        List<Rol> lista = new ArrayList<Rol>();
        Rol r= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                r = new Rol();              
                r.setIdRol(rs.getString("id_rol"));
                r.setNombre(rs.getString("nombre"));
                lista.add(r);   
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
