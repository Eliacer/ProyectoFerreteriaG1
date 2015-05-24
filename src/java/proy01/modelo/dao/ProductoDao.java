/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Producto;

/**
 *
 * @author Eliacer Fernandez
 */
public interface ProductoDao {
    
    public List<Producto> ObtenerProducto(String id);   
    public boolean InsertProducto(Producto producto);
    public boolean UpdateProducto(Producto producto);
    public boolean DeleteProducto(String id);
    public List<Producto> BuscarProducto(String Buscar_por, String Buscar);
    
    
    
}
