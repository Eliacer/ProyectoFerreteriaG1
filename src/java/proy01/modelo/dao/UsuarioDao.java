/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Comprobante;
import proy01.modelo.entidad.Privilegio;
import proy01.modelo.entidad.TipoMoneda;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public interface UsuarioDao {
    
    public Usuario validarusuario (String usuario,String password);
    public boolean agragar_usuario(Usuario usuario);
    public Usuario ObtenerUsuario(String usuario,String password);
    public List<Privilegio> ObtenerPrivUsuario(String id_usuario);
    
    
}
