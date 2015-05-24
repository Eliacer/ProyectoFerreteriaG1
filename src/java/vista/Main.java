/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vista;

import java.text.ParseException;
import java.util.List;
import proy01.modelo.dao.PersonaDao;
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.dao.TipoDocumentoDao;
import proy01.modelo.dao.UsuarioDao;
import proy01.modelo.daoImpl.PersonaDaoImpl;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.daoImpl.TipoDocumentoDaoImpl;
import proy01.modelo.daoImpl.UsuarioDaoImpl;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Producto;
import proy01.modelo.entidad.TipoDocumento;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws ParseException {
      
        Main main = new Main();
//        main.select_documento();
//        main.insert();
//        main.insertprod();
//        main.update();
//        main.delete_pro();
//        main.BuscarProducto();
        main.select();
    }
    
    public void valiarUsuario(){
    
        Usuario usuario=new Usuario();
        UsuarioDao usuarioDao= new UsuarioDaoImpl();
        
        usuarioDao.validarusuario("eliacer.fernandez", "77573082");
        
    }
    
    public void select ()
    {
        ProductoDao productoDao = new ProductoDaoImpl();
        List<Producto> listar = productoDao.ObtenerProducto("P-1405201515131231");
        System.out.printf("%-25s%-23s%-30s%-10s%-10s%-10s%-10s%-10s\n","Id","Nombre","codigo","Unidad_Medida",
                "Marca","Precio_ublico","Precio_Mayor","Precio_Credito");           
        for (Producto producto : listar) {
             System.out.printf("%-25s%-23s%-30s%-10s%-10s%-10s%-10s%-10s\n",producto.getIdProducto(),producto.getNombre(),
                     producto.getCodigo(),producto.getUndMedida(),producto.getId_marca(),producto.getPrecioPublico(),producto.getPrecioMayor(),
                     producto.getPrecioCredito());
            
            
        }
    }
    
    public void select_documento ()
    {
        TipoDocumentoDao tipoDocumentoDao = new TipoDocumentoDaoImpl();
        List<TipoDocumento> lista = tipoDocumentoDao.ListarTipoDocumento();
        System.out.printf("%-10s%-30s\n","Id","tipoDocumento");           
        for (TipoDocumento tipoDocumento : lista) {
             System.out.printf("%-10s%-30s\n",tipoDocumento.getIdTipoDocumento(),tipoDocumento.getNombre());

        }
    }   
    
    public void insertprod ()
    {
        ProductoDao productoDao = new ProductoDaoImpl();
        
        
        Producto producto= new Producto();
        producto.setIdProducto("4");
        producto.setCodigo("13455");
        producto.setNombre("cable");
        producto.setUndMedida("0003");
        producto.setMedida("20");
        producto.setFechaReg("12/05/13");
        producto.setPrecioPublico(5.3);
        producto.setPrecioMayor(7.2);
        producto.setPrecioCredito(8.5);
        producto.setId_categoria("003");
        producto.setId_marca("001");
        producto.setId_ubicacion("002");
        producto.setColor("verde");
        producto.setDescripcion("bbbb");
        
        if (productoDao.InsertProducto(producto)) {
            System.out.println("Se inserto correctamente");
        } else {
            System.out.println("Ocurrio un error al insertar");
        }
        
    }
    
    public void update ()
    {
        PersonaDao personaDao = new PersonaDaoImpl();
        Persona persona= new Persona();
        persona.setIdPersona("3");
        persona.setNombres("Floraaaa");
        persona.setApellidos("Sangama Sangama");
        persona.setNumeroDoc("67584903");
        
        if (personaDao.UpdatePersona(persona)) {
            System.out.println("Se actualizo correctamente");
        } else {
            System.out.println("Ocurrio un error al actualizar");
        }
        
    }
    
    public void delete ()
    {
        PersonaDao personaDao = new PersonaDaoImpl();

        if (personaDao.DeletePersona("P-1305201513082240")) {
            System.out.println("Se elimino correctamente");
        } else {
            System.out.println("Ocurrio un error al eliminar");
        }
        
    }
    
    public void delete_pro ()
    {
        ProductoDao dao = new ProductoDaoImpl();

        //P-1305201513121389  P-1305201513034664  P-1305201513113201 P-1305201513094675  P-1305201513114386
        if (dao.DeleteProducto("P-1305201513111327")) {
            System.out.println("Se elimino correctamente");
        } else {
            System.out.println("Ocurrio un error al eliminar");
        }
        
    }
    
    public void BuscarProducto(){
        
        ProductoDao dao = new ProductoDaoImpl();
        Producto p = new Producto();
        
        System.out.printf("%-10s%-30s\n","Nombre","Precio Credito");
//        dao.ObtenerProductoId("P-1505201515175790");
        
            System.out.printf("%-10s%-30s\n",p.getNombre(),p.getPrecioCredito());
            
        
    }
}
