/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.TipoDocumento;

/**
 *
 * @author Eliacer Fernandez
 */
public interface PersonaDao {
    
    public boolean InsertarPersona(Persona persona);
    public List<Persona> ListarPersona();
    public boolean UpdatePersona(Persona persona);
    public boolean DeletePersona(String id);
    
    
}
