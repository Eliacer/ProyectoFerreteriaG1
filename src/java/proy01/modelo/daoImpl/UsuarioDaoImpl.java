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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import proy01.modelo.conexion.ConectarOracle;
import proy01.modelo.dao.UsuarioDao;
import proy01.modelo.entidad.Privilegio;
import proy01.modelo.entidad.Usuario;
import proy01.modelo.util.HibernateUtil;

/**
 *
 * @author Eliacer Fernandez
 */
public class UsuarioDaoImpl implements UsuarioDao{
    
    public Connection open(){
        return ConectarOracle.conectar();
    }
    
    public Usuario validarusuario(String usuario, String password) {
        Usuario user=null;
        Session session=null;
        SessionFactory sf=null;
        
        try {
            sf=HibernateUtil.getSessionFactory();
            session=sf.openSession();
            Query query=session.createQuery("from Usuario where login='"+usuario+"' and password='"+password+"' and estado='1'");
            user=(Usuario)query.uniqueResult();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.close();
        }
        
        return user;
    }

    @Override
    public boolean agragar_usuario(Usuario usuario) {
        
        boolean estado=false;
        SessionFactory sf=null;
        Session session=null;
        Transaction transaction=null;
        
        try {
            sf=HibernateUtil.getSessionFactory();
            session=sf.openSession();
            transaction=session.beginTransaction();
            session.save(usuario);
            transaction.commit();
            session.close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            session.close();
            estado=false;
        }
        
        return estado;
    }

    @Override
    public List<Usuario> ObtenerUsuario(String usuario, String password) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from usuario where login='"+usuario+"' and password='"+password+"' and estado='1'";
        Usuario u = null;
        List<Usuario> lista = new ArrayList<Usuario>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                u= new Usuario();
                u.setIdUsuario(rs.getString("id_usuario"));
                u.setIdRol(rs.getString("id_rol"));
                u.setLogin(rs.getString("login"));
                u.setPassword(rs.getString("password"));             
                lista.add(u);
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
    public List<Privilegio> ObtenerPrivUsuario(String usuario) {
        Statement st = null;
        ResultSet rs= null;
        String query = "select priv.id_privilegio as id,priv.nombre as nombre from usuario u, "
                    + "rol r, privilegio priv,rol_privilegio rpr " 
                    + "where u.id_rol=r.id_rol and r.id_rol=rpr.id_rol and priv.id_privilegio=rpr.id_privilegio "
                    + "and u.id_usuario='"+usuario+"' and rpr.estado='1'";
        Privilegio priv = null;
        List<Privilegio> lista = new ArrayList<Privilegio>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                priv= new Privilegio();
                priv.setIdPrivilegio(rs.getString("id"));
                priv.setNombre(rs.getString("nombre"));
                lista.add(priv);
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
    
    

