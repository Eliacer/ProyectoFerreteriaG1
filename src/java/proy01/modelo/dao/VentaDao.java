/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.CatCliente;
import proy01.modelo.entidad.Comprobante;
import proy01.modelo.entidad.ComprobanteConfig;
import proy01.modelo.entidad.DetalleVenta;
import proy01.modelo.entidad.FormaPago;
import proy01.modelo.entidad.Rep_ventas;
import proy01.modelo.entidad.TipoMoneda;
import proy01.modelo.entidad.Venta;

/**
 *
 * @author Eliacer Fernandez
 */
public interface VentaDao {
    
    public ComprobanteConfig ObtenerCompConfig(String idcomprobante);
    public List<FormaPago> ListarFormapago();
    public List<TipoMoneda> ListarMoneda();
    public CatCliente ObtenerDcto(String id_venta);
    public boolean RegistrarVenta(Venta venta);
    public boolean IniciarVenta(String id_config);
    public List<Comprobante> ListarCompVenta();
    public boolean RegistrarDetVenta(DetalleVenta detalleVenta);
    public Venta ObtenerNumComp(String id_usuario,String id_cliente,String id_config);
    public Venta ObtenerVenta(String numComp, String id_configuracion);
    public Venta ObtenerVentaid(String id_venta);
    public Venta ObtenerDatosVenta(String id_venta);
    public DetalleVenta ObtenerDetVenta(String id_venta,String id_producto);
    public List<DetalleVenta> ListarProductosVenta(String id_venta);
    public boolean Stockventa(String id_venta);
    public boolean DeleteProdVenta(String id_venta,String id_producto);
    public boolean UpdateDetVenta(DetalleVenta detalleVenta);
    public boolean UpdateVenta(Venta venta);
    
    public List<Rep_ventas> ListarVentas(String f_in,String f_fn);
    
    
    
}
