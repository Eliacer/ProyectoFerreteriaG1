/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Vista;

import proy01.modelo.dao.PersonaDao;
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.dao.UsuarioDao;
import proy01.modelo.daoImpl.PersonaDaoImpl;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.daoImpl.UsuarioDaoImpl;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Privilegio;
import proy01.modelo.entidad.Producto;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        NewMain main = new NewMain();
//        main.insertprod();
//        main.obtUsuario();
//        main.obtUsuariopriv();
        main.actPersona();
//        main.obtPersona();
    }
    
    public void insertprod()
    {
    
        Producto p= new Producto();
        ProductoDao dao = new ProductoDaoImpl();
    
        p.setCodigo("566565");
        p.setNombre("hghgh");
        p.setColor("blanco");
        p.setConcentracion(23.4);
        p.setIdUndMedida("0001");
        p.setId_categoria("00004");
        p.setId_marca("00003");
        p.setId_ubicacion("00002");
        
        if(dao.InsertProducto(p)){
            System.out.println("Se ingreso correctamente");
        
        }
        else{
            System.out.println("no se pudo agregar");
        }
        
    }
    
    public void obtUsuario(){
    
        UsuarioDao dao = new UsuarioDaoImpl();
        
        for(Usuario u:dao.ObtenerUsuario("eliacer.fernandez", "77573082")){
            System.out.println("id"+u.getIdUsuario());
        }
    }
    
    public void obtUsuariopriv(){
    
        UsuarioDao dao = new UsuarioDaoImpl();
        
        for(Privilegio u:dao.ObtenerPrivUsuario("P-EL2405201507120733")){
            System.out.println("id: "+u.getIdPrivilegio());
            System.out.println("prilegio: "+u.getNombre());
        }
    }
    
    public void obtPersona (){
        
        Persona persona = new Persona();
        PersonaDao dao = new PersonaDaoImpl();
        
        dao.ObtenerPersonaDni("77573082");
        
        System.out.println("nombre: "+persona.getNombre_razon());
    
    }
    
    public void actPersona(){
        
        Persona p = new Persona();
        PersonaDao dao = new PersonaDaoImpl();
        
        p.setNombre_razon("Eliacerfer");
        p.setApellidos("hghghghg");
        p.setGenero("M");
        p.setId_persona("P-EL2405201507120733");
        p.setCelular("5555555");
        p.setId_tipo_doc("00001");
        p.setEstado("0");
        if(dao.UpdatePersona(p)){
            System.out.println("se ac correct");
        }
        else{
            System.out.println("no se pudo  ac correct");
        }
        
        
        
    }
}
