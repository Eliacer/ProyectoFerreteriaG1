/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.Comprobante;
import proy01.modelo.entidad.DetalleCompra;
import proy01.modelo.entidad.FormaPago;
import proy01.modelo.entidad.Rep_compras;
import proy01.modelo.entidad.TipoMoneda;

/**
 *
 * @author Eliacer Fernandez
 */
public interface CompraDao {
    
    public boolean RegistrarCompra(Compra compra);
    public boolean RegistrarDetCompra(DetalleCompra detalleCompra);
    public List<Comprobante> ListarComprobante();
    public List<FormaPago> ListarFormapago();
    public List<TipoMoneda> ListarMoneda();
    public List<Compra> ListarCompra( String num_com);
    public Rep_compras ListarCompraT(String num_comp);
    public List<DetalleCompra> ListarProductosCompra(String id_compra);
    public DetalleCompra ObtenerDetCompra(String id_compra,String id_producto);
    public boolean StockCompra(String id_compra);
    
}
