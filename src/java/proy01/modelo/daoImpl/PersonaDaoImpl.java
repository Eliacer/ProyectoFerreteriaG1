
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
import proy01.modelo.entidad.CatCliente;
import proy01.modelo.entidad.Cliente;
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
                    + " (nombres, "
                    + " apellidos, "
                    + " razon_social, "
                    + " genero, "
                    + " fecha_nac, "
                    + " telefono, "
                    + " celular, "
                    + " id_tipo_doc, "
                    + " numero_doc, "
                    + " ruc, "
                    + " direccion) "
                    + " values('"+ persona.getNombres()+"',"
                    + " '"+ persona.getApellidos()          +"',"
                    + " '"+ persona.getRazon_social()       +"',"
                    + " '"+ persona.getGenero()             +"',"
                    + " to_date('"+ persona.getFecha_nac()+"','yyyy-mm-dd'),"
                    + " '"+ persona.getTelefono()           +"',"
                    + " '"+ persona.getCelular()            +"',"
                    + " '"+ persona.getId_tipo_doc()        +"',"
                    + " '"+ persona.getNumero_doc()         +"',"
                    + " '"+ persona.getRuc()                +"',"
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
        String sql = "SELECT id_persona as id,nombres||' '||apellidos ||' '||razon_social as nombres, numero_doc as doc, "
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
                persona.setNombres(rs.getString("nombres"));
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
                +"  nombres=initcap('"+persona.getNombres()
                +"'),apellidos=initcap('"+persona.getApellidos()
                //+"',fecha_nac= to_date('"+persona.getFecha_nac()+"','yyyy-mm-dd')"
                +"'),razon_social=upper('"+persona.getRazon_social()
                +"'),genero='"+persona.getGenero()
                +"',telefono='"+persona.getTelefono()
                +"',celular='"+persona.getCelular()
                +"',id_tipo_doc='"+persona.getId_tipo_doc()
                +"',numero_doc='"+persona.getNumero_doc()
                +"',ruc='"+persona.getRuc()
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
        String query = "select id_persona, nombres||' '||apellidos as nombre,numero_doc, fecha_nac, "
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
                per.setNombres(rs.getString("nombre"));
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
        String sql = "select pr.id_proveedor as id,p.razon_social||' ( '||p.ruc||' )' as nombre "
                    + "from persona p, proveedor pr "
                    + "where p.id_persona=pr.id_proveedor and "
                    + "upper(p.razon_social) like upper('%"+proveedor+"%') order by nombre asc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setId_persona(rs.getString("id"));
                persona.setRazon_social(rs.getString("nombre"));
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
    public Persona ObtenerPersonaDni(String dni) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from persona where numero_doc='"+dni+"'";
        Persona per = null;
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            if (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombres(rs.getString("nombres"));
                per.setRazon_social(rs.getString("razon_social"));
                per.setApellidos(rs.getString("apellidos"));         
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setGenero(rs.getString("genero"));
                per.setTelefono(rs.getString("telefono"));
                per.setCelular(rs.getString("celular"));
                per.setId_tipo_doc(rs.getString("id_tipo_doc"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setRuc(rs.getString("ruc"));
                per.setEstado(rs.getString("estado"));
                per.setDireccion(rs.getString("direccion")); 
                
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return per;
    }
    
    @Override
    public Persona ObtenerPersonaRuc(String ruc) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from persona where ruc='"+ruc+"'";
        Persona per = null;
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            if (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombres(rs.getString("nombres"));
                per.setRazon_social(rs.getString("razon_social"));
                per.setApellidos(rs.getString("apellidos"));         
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setGenero(rs.getString("genero"));
                per.setTelefono(rs.getString("telefono"));
                per.setCelular(rs.getString("celular"));
                per.setId_tipo_doc(rs.getString("id_tipo_doc"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setRuc(rs.getString("ruc"));
                per.setEstado(rs.getString("estado"));
                per.setDireccion(rs.getString("direccion")); 
                
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return per;
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
    public Persona ObtenerPersonaId(String id_persona) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from persona where id_persona='"+id_persona+"'";
        Persona per = null;
        System.out.println(query);
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            if (rs.next()) {
                per= new Persona();
                per.setId_persona(rs.getString("id_persona"));
                per.setNombres(rs.getString("nombres"));
                per.setRazon_social(rs.getString("razon_social"));
                per.setApellidos(rs.getString("apellidos"));         
                per.setFecha_nac(rs.getString("fecha_nac"));
                per.setGenero(rs.getString("genero"));
                per.setTelefono(rs.getString("telefono"));
                per.setCelular(rs.getString("celular"));
                per.setId_tipo_doc(rs.getString("id_tipo_doc"));
                per.setNumero_doc(rs.getString("numero_doc"));
                per.setRuc(rs.getString("ruc"));
                per.setEstado(rs.getString("estado"));
                per.setDireccion(rs.getString("direccion")); 
                System.out.println(per.getNombres());
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return per;
    }

    @Override
    public boolean RegistrarCliente(Cliente cliente) {
        
        boolean estado=false;
        Statement st;
        String sql = "insert into cliente "
                    + " (id_cliente, "
                    + " id_categoria) "
                    + " values('"+ cliente.getIdCliente()+"',"
                    + " '"+ cliente.getIdTipoCliente()   +"')";
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
    public List<Persona> Listarcliente(String cliente) {
       
        Statement st;
        ResultSet rs;
        String sql = "select cl.id_cliente as id,p.nombres||' '||p.apellidos||' '||p.razon_social ||'-'||p.numero_doc as nombre "
                    + "from persona p, cliente cl "
                    + "where p.id_persona=cl.id_cliente and "
                    + "(p.numero_doc) like ('%"+cliente+"%') and "
                    + "rownum <=3 order by nombre asc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setId_persona(rs.getString("id"));
                persona.setRazon_social(rs.getString("nombre"));
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
    public List<CatCliente> ListarCatCliente() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_categoria,initcap(nombre) as nombre, dcto from cat_cliente ";
        List<CatCliente> lista = new ArrayList<CatCliente>();
        CatCliente catc= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                catc = new CatCliente();              
                catc.setIdCategoria(rs.getString("id_categoria"));
                catc.setNombre(rs.getString("nombre")); 
                catc.setDescuento(rs.getDouble("dcto"));
                lista.add(catc);   
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
    public List<Persona> ListarCliente() {
        
        Statement st;
        ResultSet rs;
        String sql = "SELECT p.nombres||' '||p.apellidos as nombres,p.razon_social as rz,p.numero_doc as doc, "
                   + "to_char(p.fecha_nac,'dd/mm/yyyy') as fecha, "
                   + "p.telefono||' / '||p.celular as tel, p.direccion as dir, p.estado as est "
                   + "FROM persona p,cliente c where p.id_persona=c.id_cliente order by fecha desc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setNombres(rs.getString("nombres"));
                persona.setRazon_social(rs.getString("rz"));
                persona.setFecha_nac(rs.getString("fecha"));
                persona.setTelefono(rs.getString("tel"));
                persona.setNumero_doc(rs.getString("doc"));
                persona.setDireccion(rs.getString("dir"));
                persona.setEstado(rs.getString("est"));
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
    public List<Persona> ListarProveedor() {
        
        Statement st;
        ResultSet rs;
        String sql = "SELECT p.razon_social as rz,p.ruc as ruc, "
                   + "pr.correo_electronico as correo,pr.num_cuenta as ncuenta, "
                   + "p.telefono||' / '||p.celular as tel, p.direccion as dir, pr.estado as est "
                   + "FROM persona p,proveedor pr where p.id_persona=pr.id_proveedor and pr.estado='1'";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setRazon_social(rs.getString("rz"));
                persona.setTelefono(rs.getString("tel"));
                persona.setRuc(rs.getString("ruc"));
                persona.setDireccion(rs.getString("dir"));
                persona.setCorreo(rs.getString("correo"));
                persona.setNum_cuenta(rs.getString("ncuenta"));
                persona.setEstado(rs.getString("est"));
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
    public List<Persona> ListarUsuario() {
        
        Statement st;
        ResultSet rs;
        String sql = "SELECT p.nombres||' '||p.apellidos as nombres,p.numero_doc as doc, "
                   + "to_char(p.fecha_nac,'dd/mm/yyyy') as fecha,u.login as login,nombre_rol(u.id_rol) as rol, "
                   + "p.telefono||' / '||p.celular as tel, p.direccion as dir, p.estado as est "
                   + "FROM persona p,usuario u where p.id_persona=u.id_usuario order by fecha asc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setNombres(rs.getString("nombres"));
                persona.setFecha_nac(rs.getString("fecha"));
                persona.setTelefono(rs.getString("tel"));
                persona.setNumero_doc(rs.getString("doc"));
                persona.setDireccion(rs.getString("dir"));
                persona.setUsuario(rs.getString("login"));
                persona.setRol(rs.getString("rol"));
                persona.setEstado(rs.getString("est"));


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
    public List<Persona> ListarClientePotencial() {
        
        Statement st;
        ResultSet rs;
        String sql = "select * from(select nombre_cliente(c.id_cliente) as cliente, "
                   + "p.numero_doc as dni,p.celular||' '||p.telefono as contacto, "
                   + "trunc(monto_cliente(c.id_cliente),2) as monto "
                   + "from cliente c,persona p where p.id_persona=c.id_cliente "
                   + "order by monto desc) where rownum <=4 ";
        
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setNombres(rs.getString("cliente"));
                persona.setTelefono(rs.getString("contacto"));
                persona.setNumero_doc(rs.getString("dni"));
                persona.setEstado(rs.getString("monto"));
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
    public List<Proveedor> ListarProveedorPotencial() {
        
        Statement st;
        ResultSet rs;
        String sql = "select * from ( select distinct nombre_proveedor(c.id_proveedor) as proveedor,per.ruc as ruc, "
                    + "p.correo_electronico as correo,round(monto_proveedor(c.id_proveedor),2) as monto "
                    + "from compra c,proveedor p,persona per "
                    + "where p.id_proveedor=c.id_proveedor and per.id_persona=p.id_proveedor order by monto desc) "
                    + "where rownum <=4";
        
        List<Proveedor> lista = new ArrayList<Proveedor>();
        Proveedor proveedor = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                proveedor = new Proveedor();
                proveedor.setId_proveedor(rs.getString("proveedor"));
                proveedor.setCorreo_electronico(rs.getString("correo"));
                proveedor.setNum_cuenta(rs.getString("ruc"));
                proveedor.setEstado(rs.getString("monto"));
                lista.add(proveedor);                
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
    
}
