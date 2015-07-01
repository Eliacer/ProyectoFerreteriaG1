/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.daoImpl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import proy01.modelo.conexion.ConectarOracle;
import proy01.modelo.dao.VentaDao;
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
public class VentaDaoImpl implements VentaDao{

    public Connection open(){
        
        return ConectarOracle.conectar();
    }
    
    @Override
    public List<FormaPago> ListarFormapago() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_forma_pago,initcap(nombre) as nombre from forma_pago ";
        List<FormaPago> lista = new ArrayList<FormaPago>();
        FormaPago tp= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                tp = new FormaPago();              
                tp.setIdFormaPago(rs.getString("id_forma_pago"));
                tp.setNombre(rs.getString("nombre"));           
                lista.add(tp);   
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return lista; 
    }

    @Override
    public List<Comprobante> ListarCompVenta() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_configuracion as id,nombre_comp(id_comprobante) as nombre " +
                     "from comprobante_config where estado='1'";
        List<Comprobante> lista = new ArrayList<Comprobante>();
        Comprobante comp= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                comp = new Comprobante();              
                comp.setIdComprobante(rs.getString("id"));
                comp.setNombreComprobante(rs.getString("nombre"));           
                lista.add(comp);   
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return lista; 
        
        
    }

    @Override
    public List<TipoMoneda> ListarMoneda() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_moneda,initcap(nombre) as nombre, valor_actual from tipo_moneda ";
        List<TipoMoneda> lista = new ArrayList<TipoMoneda>();
        TipoMoneda tm= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                tm = new TipoMoneda();              
                tm.setIdMoneda(rs.getString("id_moneda"));
                tm.setNombre(rs.getString("nombre")); 
                tm.setValorActual(rs.getDouble("valor_actual"));
                lista.add(tm);   
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return lista; 
    }

    @Override
    public boolean IniciarVenta(String id_config) {
        
        boolean estado = false;
        Statement st = null;
        String query="BEGIN actualizar_contmax('"+id_config+"'); end;";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
        return estado;
    }
 
    @Override
    public boolean RegistrarVenta(Venta venta) {
        
        boolean estado = false;
        Statement st = null;
        String query="insert into venta "
                    + "(id_usuario, "
                    + "id_cliente, "
                    + "id_configuracion, "
                    + "id_forma_pago, "
                    + "id_categoria,igv) "
                    + "values('"+venta.getId_usuario()  +"',"
                    + "'"+venta.getId_cliente()         +"',"
                    + "'"+venta.getId_configuracion()   +"',"
                    + "'"+venta.getId_formaPago()       +"',"
                    + "'"+venta.getIdTipoCliente()      +"',"
                    + venta.getIgv()+")";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
        return estado;
        
    }
    
    @Override
    public boolean RegistrarDetVenta(DetalleVenta detalleVenta) {
        
        double descuento=0;
        descuento=(detalleVenta.getCantidad()*detalleVenta.getPreciounitario())*(detalleVenta.getDescuento()/100);
        
        boolean estado = false;
        Statement st = null;
        String query="insert into venta_detalle "
                    + "(id_venta, "
                    + "id_producto, "
                    + "cantidad, "
                    + "precio_unitario, "
                    + "descuento,control) "
                    + "values('"+detalleVenta.getId_venta()  +"',"
                    + "'"+detalleVenta.getId_producto()      +"',"
                    + ""+detalleVenta.getCantidad()          +","
                    + ""+detalleVenta.getPreciounitario()   +","
                    + ""+descuento+",'0')";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }
        return estado;
    }

    @Override
    public boolean Stockventa(String id_venta) {
        
        boolean estado = false;
        Statement st = null;
        String query="BEGIN STOCK_VENTA('"+id_venta+"'); END;";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }  
        return estado;
    }

    @Override
    public ComprobanteConfig ObtenerCompConfig(String id_configuracion) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_configuracion,id_comprobante,serie "
                    + "from comprobante_config "
                    + "where id_configuracion='"+id_configuracion+"'";
        
        ComprobanteConfig comprobante= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                comprobante = new ComprobanteConfig();              
                comprobante.setIdConfiguracion(rs.getString("id_configuracion"));
                comprobante.setIdComprobante(rs.getString("id_comprobante")); 
                comprobante.setSerie(rs.getString("serie"));   
              
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {             
            }
        }
        return comprobante;
    }
 
    @Override
    public Venta ObtenerNumComp(String id_usuario, String id_cliente, String id_config) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select max(num_comprobante) as comp from venta where id_usuario='"+id_usuario+"' "
                    + "and id_cliente='"+id_cliente+"' and id_configuracion=('"+id_config+"')";
        Venta venta= null;
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                venta = new Venta();              
                venta.setNumComprobante(rs.getString("comp"));
                
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return venta;
    }

    
    
            
    @Override
    public Venta ObtenerVentaid(String id_venta) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from venta where id_venta='"+id_venta+"'";
        Venta venta= null;
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                venta = new Venta();              
                venta.setId_venta(rs.getString("id_venta"));
                venta.setId_usuario(rs.getString("id_usuario"));
                venta.setId_cliente(rs.getString("id_cliente")); 
                venta.setFechaventa(rs.getString("fecha_venta")); 
                venta.setId_formaPago(rs.getString("id_forma_pago"));   
                venta.setId_configuracion(rs.getString("id_configuracion")); 
                venta.setIdTipoCliente(rs.getString("id_categoria")); 
                venta.setIgv(rs.getDouble("igv"));
                venta.setNumComprobante(rs.getString("num_comprobante"));
                venta.setEstado(rs.getString("estado"));
                         
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return venta;
    }
    
    @Override
    public Venta ObtenerVenta(String numComp, String config) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_venta from venta where num_comprobante='"+numComp+"' and id_configuracion=('"+config+"')";
        Venta venta= null;
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                venta = new Venta();              
                venta.setId_venta(rs.getString("id_venta"));
                         
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return venta;
    }

    @Override
    public DetalleVenta ObtenerDetVenta(String id_venta, String id_producto) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_venta,id_producto,cantidad,precio_unitario "
                    + "from venta_detalle where id_venta='"+id_venta+"' and id_producto='"+id_producto+"'";
        DetalleVenta detalleVenta= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                detalleVenta = new DetalleVenta();              
                detalleVenta.setId_venta(rs.getString("id_venta"));
                detalleVenta.setId_producto(rs.getString("id_producto"));
                detalleVenta.setCantidad(rs.getInt("cantidad")); 
                detalleVenta.setPreciounitario(rs.getDouble("precio_unitario")); 
                 
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return detalleVenta;
    }
   
    @Override
    public List<DetalleVenta> ListarProductosVenta(String id_venta) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_producto,cantidad,substr(nombre_producto(id_producto),0,20) as producto, "
                    + "precio_unitario,trunc(descuento,2) as dcto,cantidad*precio_unitario as subtotal "
                    + "from venta_detalle where id_venta='"+id_venta+"'";
        List<DetalleVenta> lista = new ArrayList<DetalleVenta>();
        DetalleVenta detalleVenta= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                detalleVenta = new DetalleVenta();              
                detalleVenta.setId_producto(rs.getString("id_producto")); 
                detalleVenta.setCantidad(rs.getInt("cantidad"));   
                detalleVenta.setProducto(rs.getString("producto")); 
                detalleVenta.setPreciounitario(rs.getDouble("precio_unitario")); 
                detalleVenta.setDescuento(rs.getDouble("dcto")); 
                detalleVenta.setSubtotal(rs.getDouble("subtotal"));
                lista.add(detalleVenta);
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return lista;
    }

    @Override
    public Venta ObtenerDatosVenta(String id_venta) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select nombre_usuario(id_usuario) as us,nombre_cliente(id_cliente) as cliente, "
                   + "to_char(fecha_venta,'dd/mm/yyyy') as fv,nombre_forma_pago(id_forma_pago) as forma, "
                   + "nombre_comp_venta(id_configuracion) as conp,serieventa(id_configuracion) as serie, "
                   + "num_comprobante,igv from venta where id_venta='"+id_venta+"'";
        Venta venta= null;
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                venta = new Venta();              
                venta.setId_usuario(rs.getString("us"));
                venta.setId_cliente(rs.getString("cliente")); 
                venta.setFechaventa(rs.getString("fv")); 
                venta.setId_formaPago(rs.getString("forma"));   
                venta.setId_configuracion(rs.getString("conp")); 
                venta.setSerie(rs.getString("serie")); 
                venta.setNumComprobante(rs.getString("num_comprobante"));  
                venta.setIgv(rs.getDouble("igv"));
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return venta;
    }

    @Override
    public boolean DeleteProdVenta(String id_venta, String id_producto) {
           
        boolean estado = false;
        Statement st = null;
        String query="delete from venta_detalle where id_venta='"+id_venta+"' and id_producto='"+id_producto+"'";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }
        }  
        return estado; 
    }

    @Override
    public boolean UpdateVenta(Venta venta) {
        
        boolean estado = false;
        Statement st = null;
        String query="update venta set id_usuario='"+venta.getId_usuario()+"', "
                    + "id_cliente='"+venta.getId_cliente()+"', "
                    + "id_configuracion='"+venta.getId_configuracion()+"', "
                    + "id_forma_pago='"+venta.getId_formaPago()+"', "
                    + "id_categoria='"+venta.getIdTipoCliente()+"', "
                    + "igv="+venta.getIgv()+" where id_venta='"+venta.getId_venta()+"'";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }       
        }
        return estado; 
    }
    
    @Override
    public boolean UpdateDetVenta(DetalleVenta dv) {
        
        double descuento=0;
        descuento=(dv.getCantidad()*dv.getPreciounitario())*(dv.getDescuento()/100);           
        boolean estado = false;
        Statement st = null;
        String query="update venta_detalle set cantidad="+dv.getCantidad()+", "
                    + "precio_unitario="+dv.getPreciounitario()+",descuento="+descuento
                    +" where id_venta='"+dv.getId_venta()+"' and id_producto='"+dv.getId_producto()+"'";
        
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                estado = false;
                open().rollback();
                open().close();
            } catch (Exception ex) {
            }       
        }
        return estado; 
    }

    @Override
    public CatCliente ObtenerDcto(String id_venta) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select porc_descuento(id_venta) as dcto from venta where id_venta='"+id_venta+"'";
        CatCliente catCliente= null;
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                catCliente = new CatCliente();              
                catCliente.setDescuento(rs.getDouble("dcto"));
                        
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
        return catCliente;
    }  

    @Override
    public List<Rep_ventas> ListarVentas(String f_in,String f_fn) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select to_char(fecha_venta,'dd/mm/yy') as fecha_venta,nombre_usuario(id_usuario) as usuario, "
                    + "nombre_cliente(id_cliente) as cliente,nombre_comp_venta(id_configuracion) as comprobante, "
                    + "num_comprobante,nombre_forma_pago(id_forma_pago) as forma_pago from venta "
                    + "where fecha_venta between to_date('"+f_in+"','yyyy-mm-dd') and to_date('"+f_fn+"','yyyy-mm-dd') " 
                    + "order by fecha_venta asc";
        
        List<Rep_ventas> lista= new ArrayList<Rep_ventas>();
        Rep_ventas rep_ventas= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                rep_ventas = new Rep_ventas();              
                rep_ventas.setFecha_venta(rs.getString("fecha_venta"));
                rep_ventas.setNombre_comprobante(rs.getString("comprobante"));
                rep_ventas.setNum_com(rs.getString("num_comprobante")); 
                rep_ventas.setNombre_usuario(rs.getString("usuario")); 
                rep_ventas.setNombre_cliente(rs.getString("cliente")); 
                rep_ventas.setNombre_forma_pago(rs.getString("forma_pago")); 
                lista.add(rep_ventas);
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return lista;
    }
}
