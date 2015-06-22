/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.DetalleCompra;
import proy01.modelo.entidad.KardexProducto;
import proy01.modelo.entidad.Producto;


/**
 *
 * @author Eliacer Fernandez
 */
public interface FijarPreciosCompraDao {
    
    public List<Compra> ListarComprasNoFijadasPrecios();
    public List<DetalleCompra> ListarCompraPrecioSugerido(String id_compra);
    public boolean UpdateProdPrecio(Producto producto);
    public boolean Updatedetapf(String id_compra, String id_producto);
    public boolean UpdatePrecio(String id_compra);
    public List<KardexProducto> Kardexproducto(String id_producto);
   
    
   
    
}
