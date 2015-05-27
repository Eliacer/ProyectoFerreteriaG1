/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.Comprobante;
import proy01.modelo.entidad.FormaPago;
import proy01.modelo.entidad.TipoMoneda;

/**
 *
 * @author Eliacer Fernandez
 */
public interface CompraDao {
    
    public boolean RegistrarCompra(Compra compra);
    public List<Comprobante> ListarComprobante();
    public List<FormaPago> ListarFormapago();
    public List<TipoMoneda> ListarMoneda();
    public Compra ListarCompra( String num_com);
    public List<Compra> ListarCompraT();
    
}
