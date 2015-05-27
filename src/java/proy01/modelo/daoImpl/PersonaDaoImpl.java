
package proy01.modelo.daoImpl;

import proy01.modelo.conexion.ConectarOracle;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import proy01.modelo.dao.PersonaDao;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Proveedor;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public class PersonaDaoImpl implements PersonaDao{
    
    public Connection open(){
        return ConectarOracle.conectar();
    }

    @Override
    public boolean InsertarPersona(Persona persona) {
        
        boolean estado=false;
        Statement st;
        String sql = "insert into persona "
                    + " (nombre_razon, "
                    + " apellidos, "
                    + " genero, "
                    + " fecha_nac, "
                    + " telefono, "
                    + " celular, "
                    + " id_tipo_doc, "
                    + " numero_doc, "
                    + " direccion) "
                    + " values('"+ persona.getNombre_razon()+"',"
                    + " '"+ persona.getApellidos()          +"',"
                    + " '"+ persona.getGenero()             +"',"
                    + " to_date('"+ persona.getFecha_nac()+"','yyyy-mm-dd'),"
                    + " '"+ persona.getTelefono()           +"',"
                    + " '"+ persona.getCelular()            +"',"
                    + " '"+ persona.getId_tipo_doc()        +"',"
                    + " '"+ persona.getNumero_doc()         +"',"
                    + " '"+ persona.getDireccion()          +"')";
        try {
            st=open().createStatement();
            st.executeUpdate(sql);
            open().commit();
            open().close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();    
            estado=false;
            try {
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
      return estado;
    }

    @Override
    public List<Persona> ListarPersona() {
        
        Statement st;
        ResultSet rs;
        String sql = "SELECT id_persona as id,nombre_razon||' '||apellidos as nombres, numero_doc as doc, "
                   + "to_char(fecha_nac,'dd/mm/yyyy') as fecha, "
                   + "telefono||' / '||celular as tel, direccion, estado FROM persona order by fecha_nac desc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setId_persona(rs.getString("id"));
                persona.setNombre_razon(rs.getString("nombres"));
                persona.setFecha_nac(rs.getString("fecha"));
                persona.setTelefono(rs.getString("tel"));
                persona.setNumero_doc(rs.getString("doc"));
                persona.setDireccion(rs.getString("direccion"));
                persona.setEstado(rs.getString("estado"));
                lista.add(persona);                
            }
            open().close();
        } catch (Exception e) {
            try {
                e.printStackTrace();
                open().close();
            } catch (SQLException ex) {
                Logger.getLogger(PersonaDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }

    @Override
    public boolean UpdatePersona(Persona persona) {
        
        boolean estado = false;
        Statement st = null;
        String query = "update persona set "
                +"  nombre_razon=initcap('"+persona.getNombre_razon()
                +"'),apellidos=initcap('"+persona.getApellidos()
                //+"',fecha_nac= to_date('"+persona.getFecha_nac()+"','yyyy-mm-dd')"
                +"'),genero='"+persona.getGenero()
                +"',telefono='"+persona.getTelefono()
                +"',celular='"+persona.getCelular()
                +"',id_tipo_doc='"+persona.getId_tipo_doc()
                +"',numero_doc='"+persona.getNumero_doc()
                +"',direccion=initcap('"+persona.getDireccion()
                +"'),estado='"+persona.getEstado()
                +"' where id_persona='"+persona.getId_persona()+"'";
       
        try {
            st = open().createStatement();
            st.executeQuery(query);
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
    public boolean DeletePersona(String id) {
        
        boolean estado = false;
        Statement st=null;
        String query="delete from persona where id_persona='"+id+"'";  
        try {
            st= open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();
            estado=false;
       try {
                open().rollback();
                open().close();                  
            } catch (Exception ex) {
            }
        }
        return estado;
    }
    
    @Override
    public List<Persona> ObtenerPersona (String nombre,String dni)
    {
        Statement st = null;
        ResultSet rs= null;
        String query = "select id_persona, nombre_razon||' '||apellidos as nombre,numero_doc, fecha_nac, "
                        + "telefono||' '||celular as telcel, direccion "
                        + "from persona where upper(nombre_razon)=upper('"+nombre+"') or "
                        + "numero_doc='"+dni+"' "
                        + "rownum <=1";
        Persona per = null;
        List<Persona> lista = new ArrayList<Persona>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombre_razon(rs.getString("nombre"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setTelefono(rs.getString("telcel"));
                per.setDireccion(rs.getString("direccion"));             
                lista.add(per);
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
    public List<Persona> ListarProveedor(String proveedor) {
        
        Statement st;
        ResultSet rs;
        String sql = "select p.id_persona as id,p.nombre_razon||' ('||p.numero_doc||' )' as nombre "
                    + "from persona p, proveedor pr "
                    + "where p.id_persona=pr.id_proveedor and "
                    + "upper(p.nombre_razon) like upper('%"+proveedor+"%') and "
                    + "rownum <=3 order by nombre asc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setId_persona(rs.getString("id"));
                persona.setNombre_razon(rs.getString("nombre"));
                lista.add(persona);                
            }
            open().close();
        } catch (Exception e) {
            try {
                e.printStackTrace();
                open().close();
            } catch (SQLException ex) {
                Logger.getLogger(PersonaDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    
    }

    @Override
    public List<Persona> ObtenerPersonaDni(String id_persona) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from persona where numero_doc='"+id_persona+"'";
        Persona per = null;
        List<Persona> lista = new ArrayList<Persona>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            if (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombre_razon(rs.getString("nombre_razon"));
                per.setApellidos(rs.getString("apellidos"));         
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setGenero(rs.getString("genero"));
                per.setTelefono(rs.getString("telefono"));
                per.setCelular(rs.getString("celular"));
                per.setId_tipo_doc(rs.getString("id_tipo_doc"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setEstado(rs.getString("estado"));
                per.setDireccion(rs.getString("direccion")); 
                lista.add(per);
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
    public boolean RegistrarProveedor(Proveedor proveedor) {
        
        boolean estado=false;
        Statement st;
        String sql = "insert into proveedor "
                    + " (id_proveedor, "
                    + " correo_electronico, "
                    + " num_cuenta) "
                    + " values('"+ proveedor.getId_proveedor()+"',"
                    + " '"+ proveedor.getCorreo_electronico() +"',"
                    + " '"+ proveedor.getNum_cuenta()         +"')";
        try {
            st=open().createStatement();
            st.executeUpdate(sql);
            open().commit();
            open().close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();    
            estado=false;
            try {
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
      return estado;
    }

    @Override
    public boolean RegistrarUsuario(Usuario usuario) {
        
        boolean estado=false;
        Statement st;
        String sql = "insert into usuario "
                    + " (id_usuario, "
                    + " login, "
                    + " password, "
                    + " id_rol) "
                    + " values('"+ usuario.getIdUsuario()+"',"
                    + " '"+ usuario.getLogin()           +"',"
                    + " '"+ usuario.getPassword()        +"',"
                    + " '"+ usuario.getIdRol()           +"')";
        try {
            st=open().createStatement();
            st.executeUpdate(sql);
            open().commit();
            open().close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();    
            estado=false;
            try {
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
      return estado;
    }

    @Override
    public List<Persona> ObtenerPersonaId(String id_persona) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from persona where id_persona='"+id_persona+"'";
        Persona per = null;
        List<Persona> lista = new ArrayList<Persona>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            if (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombre_razon(rs.getString("nombre_razon"));
                per.setApellidos(rs.getString("apellidos"));         
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setGenero(rs.getString("genero"));
                per.setTelefono(rs.getString("telefono"));
                per.setCelular(rs.getString("celular"));
                per.setId_tipo_doc(rs.getString("id_tipo_doc"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setEstado(rs.getString("estado"));
                per.setDireccion(rs.getString("direccion")); 
                lista.add(per);
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
