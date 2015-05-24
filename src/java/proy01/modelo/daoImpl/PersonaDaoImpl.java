
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
                    + " genero, "
                    + " fecha_nac, "
                    + " telefono, "
                    + " id_tipo_documento, "
                    + " numero_doc, "
                    + " direccion) "
                    + " values('"+ persona.getNombres()+"',"
                    + " '"+ persona.getApellidos()  +"',"
                    + " '"+ persona.getGenero()     +"',"
                    + " to_date('"+ persona.getFechaNac1()+"','yyyy-mm-dd'),"
                    + " '"+ persona.getTelefono()   +"',"
                    + " '"+ persona.getId_tipoDocum()+"',"
                    + " '"+ persona.getNumeroDoc()  +"',"
                    + " '"+ persona.getDireccion()  +"')";
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
        String sql = "SELECT id_persona as id,nombres||' '||apellidos||' ('||genero||')' as nombres, numero_doc as doc, "
                   + "to_char(fecha_nac,'dd/mm/yyyy') as fecha, "
                   + "telefono, direccion FROM persona order by fecha_nac desc";
        List<Persona> lista = new ArrayList<Persona>();
        Persona persona = null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {                
                persona = new Persona();
                persona.setIdPersona(rs.getString("id"));
                persona.setNombres(rs.getString("nombres"));
                persona.setFechaNac1(rs.getString("fecha"));
                persona.setTelefono(rs.getString("telefono"));
                persona.setNumeroDoc(rs.getString("doc"));
                persona.setDireccion(rs.getString("direccion"));
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
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean DeletePersona(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    

}
