/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.CatCliente;
import proy01.modelo.entidad.Rol;
import proy01.modelo.entidad.TipoDocumento;

/**
 *
 * @author Eliacer Fernandez
 */
public interface TipoDocumentoDao {
    
    public List<TipoDocumento> ListarTipoDocumento();
    public List<Rol> ListarRoles();
    public List<CatCliente> ListarCatCliente();
    
}
