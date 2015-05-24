/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.daoImpl;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import proy01.modelo.dao.UsuarioDao;
import proy01.modelo.entidad.Usuario;
import proy01.modelo.util.HibernateUtil;

/**
 *
 * @author Eliacer Fernandez
 */
public class UsuarioDaoImpl implements UsuarioDao{
    
    public Usuario validarusuario(String usuario, String password) {
        Usuario user=null;
        Session session=null;
        SessionFactory sf=null;
        
        try {
            sf=HibernateUtil.getSessionFactory();
            session=sf.openSession();
            Query query=session.createQuery("from Usuario where login='"+usuario+"' and password='"+password+"'");
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
    
}
