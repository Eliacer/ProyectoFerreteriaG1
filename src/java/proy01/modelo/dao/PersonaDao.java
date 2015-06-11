/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.CatCliente;
import proy01.modelo.entidad.Cliente;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Proveedor;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public interface PersonaDao {
    
    public boolean InsertarPersona(Persona persona);
    public List<Persona> ListarPersona();
    public List<CatCliente> ListarCatCliente();
    public List<Persona> ListarProveedor(String proveedor);
    public List<Persona> Listarcliente(String proveedor);
    public boolean UpdatePersona(Persona persona);
    public boolean DeletePersona(String id);
    public List<Persona> ObtenerPersona (String nombre,String dni);
    //public List<Persona> ObtenerPersonaId (String id);
    public Persona ObtenerPersonaId (String id);
    public Persona ObtenerPersonaDni (String dni);
    public boolean RegistrarProveedor(Proveedor proveedor);
    public boolean RegistrarUsuario(Usuario usuario);
    public boolean RegistrarCliente(Cliente cliente);
    
}
