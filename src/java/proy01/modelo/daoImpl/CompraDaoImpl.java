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
import proy01.modelo.dao.CompraDao;
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
public class CompraDaoImpl implements CompraDao{

    public Connection open(){
        
        return ConectarOracle.conectar();
    }
    
    @Override
    public List<Comprobante> ListarComprobante() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_comprobante,initcap(nombre) as nombre from comprobante ";
        List<Comprobante> lista = new ArrayList<Comprobante>();
        Comprobante comp= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                comp = new Comprobante();              
                comp.setIdComprobante(rs.getString("id_comprobante"));
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
    public List<TipoMoneda> ListarMoneda() {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_moneda,initcap(nombre) as nombre, valor_actual from tipo_moneda where estado='1'";
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
    public Compra ListarCompra(String num_com) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from compra where num_comprobante='"+num_com+"'";
        Compra compra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                compra = new Compra();              
                compra.setId_compra(rs.getString("id_compra"));
                compra.setId_usuario(rs.getString("id_usuario")); 
                compra.setId_proveedor(rs.getString("id_proveedor"));   
                compra.setId_tipoMoneda(rs.getString("id_moneda")); 
                compra.setId_comprobante(rs.getString("id_comprobante")); 
                compra.setNumComprobante(rs.getString("num_comprobante")); 
                compra.setId_formaPago(rs.getString("id_forma_pago")); 
                compra.setFechaCompra(rs.getString("fecha_compra"));
                compra.setDescripcion(rs.getString("descripcion"));
                compra.setIgv(rs.getString("igv"));
                compra.setFlete(rs.getString("flete"));   
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return compra; 
    
    }
    
    @Override
    public Compra ListarCompraid(String id_compra) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select * from compra where id_compra='"+id_compra+"'";
        Compra compra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                compra = new Compra();              
                compra.setId_compra(rs.getString("id_compra"));
                compra.setId_usuario(rs.getString("id_usuario")); 
                compra.setId_proveedor(rs.getString("id_proveedor"));   
                compra.setId_tipoMoneda(rs.getString("id_moneda")); 
                compra.setId_comprobante(rs.getString("id_comprobante")); 
                compra.setNumComprobante(rs.getString("num_comprobante")); 
                compra.setId_formaPago(rs.getString("id_forma_pago")); 
                compra.setFechaCompra(rs.getString("fecha_compra"));
                compra.setDescripcion(rs.getString("descripcion"));
                compra.setIgv(rs.getString("igv"));
                compra.setFlete(rs.getString("flete"));   
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return compra; 
    
    }

    @Override
    public boolean RegistrarCompra(Compra compra) {
        
        boolean estado = false;
        Statement st = null;
        String query="insert into compra "
                    + "(id_usuario, "
                    + "id_proveedor, "
                    + "id_moneda, "
                    + "id_comprobante, "
                    + "num_comprobante, "
                    + "id_forma_pago, "
                    + "fecha_compra, "
                    + "descripcion, "
                    + "igv, "
                    + "flete) "
                    + "values('"+compra.getId_usuario()+"',"
                    + "'"+compra.getId_proveedor()+"',"
                    + "'"+compra.getId_tipoMoneda()+"',"
                    + "'"+compra.getId_comprobante()+"',"
                    + "'"+compra.getNumComprobante()+"',"
                    + "'"+compra.getId_formaPago()+"',"
                    + "to_date('"+compra.getFechaCompra()+"','yyyy-mm-dd'),"
                    + "'"+compra.getDescripcion()+"',"
                    + ""+Double.parseDouble(compra.getIgv())+","
                    + ""+Double.parseDouble(compra.getFlete())+")";
        
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
    public Rep_compras ListarCompraT(String id_compra) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_compra, nombre_usuario(id_usuario) as usuario,nombre_proveedor(id_proveedor) as proveedor, "
                    + "nombre_tipo_moneda(id_moneda) as moneda, valor_moneda, nombre_comp(id_comprobante) as comprobante, "
                    + "num_comprobante, nombre_forma_pago(id_forma_pago) as fpago, to_char(fecha_compra,'dd/mm/yyyy') as fecha_compra, "
                    + "igv, flete,direccion_proveedor(id_proveedor) as direccion,abrev_moneda(id_moneda) as abrev "
                    + "from compra where id_compra='"+id_compra+"'";
        Rep_compras rep_compras= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                rep_compras = new Rep_compras();              
                rep_compras.setId_compra(rs.getString("id_compra"));
                rep_compras.setNombre_usuario(rs.getString("usuario")); 
                rep_compras.setNombre_proveedor(rs.getString("proveedor"));   
                rep_compras.setNombre_tipo_moneda(rs.getString("moneda")); 
                rep_compras.setValor_moneda(rs.getDouble("valor_moneda"));
                rep_compras.setAbrev_moneda(rs.getString("abrev"));
                rep_compras.setNombre_comprobante(rs.getString("comprobante")); 
                rep_compras.setNum_com(rs.getString("num_comprobante")); 
                rep_compras.setNombre_forma_pago(rs.getString("fpago")); 
                rep_compras.setFecha_compra(rs.getString("fecha_compra"));
                rep_compras.setIgv(rs.getString("igv"));
                rep_compras.setFlete(rs.getString("flete"));  
                rep_compras.setDireccion_prov(rs.getString("direccion")); 
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return rep_compras;
    }

    @Override
    public List<DetalleCompra> ListarProductosCompra(String id_compra) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_compra,id_producto,cant_mayor as cant,und_producto(id_compra,id_producto) as und, "
                + "substr(nombre_producto(id_producto),0,20) as producto,costo_mayor,cant_mayor*costo_mayor as importe "
                + "from compra_detalle where id_compra='"+id_compra+"'";
        List<DetalleCompra> lista = new ArrayList<DetalleCompra>();
        DetalleCompra detalleCompra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                detalleCompra = new DetalleCompra();              
                detalleCompra.setId_compra(rs.getString("id_compra"));
                detalleCompra.setCantMayor(rs.getInt("cant")); 
                detalleCompra.setId_unidad(rs.getString("und"));   
                detalleCompra.setId_producto(rs.getString("id_producto")); 
                detalleCompra.setProducto(rs.getString("producto")); 
                detalleCompra.setCostoMayor(rs.getDouble("costo_mayor")); 
                detalleCompra.setImporte(rs.getDouble("importe")); 
                lista.add(detalleCompra);
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
    public boolean RegistrarDetCompra(DetalleCompra detalleCompra) {
        
        boolean estado = false;
        Statement st = null;
        String query="insert into compra_detalle "
                    + "(id_compra, "
                    + "id_producto, "
                    + "id_unidad, "
                    + "cant_mayor, "
                    + "cant_menor, "
                    + "costo_mayor,pf,control) "
                    + "values('"+detalleCompra.getId_compra()+"',"
                    + "'"+detalleCompra.getId_producto()+"',"
                    + "'"+detalleCompra.getId_unidad()+"',"
                    + detalleCompra.getCantMayor()+","
                    + detalleCompra.getCantMenor()+","
                    + detalleCompra.getCostoMayor()+",'0','0')";
        
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
    public DetalleCompra ObtenerDetCompra(String id_compra, String id_producto) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_compra,id_producto,cant_mayor,cant_menor,id_unidad as und,costo_mayor "
                + "from compra_detalle where id_compra='"+id_compra+"' and id_producto='"+id_producto+"'";
        DetalleCompra detalleCompra= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                detalleCompra = new DetalleCompra();              
                detalleCompra.setId_compra(rs.getString("id_compra"));
                detalleCompra.setId_producto(rs.getString("id_producto"));
                detalleCompra.setCantMayor(rs.getInt("cant_mayor")); 
                detalleCompra.setCantMenor(rs.getInt("cant_menor")); 
                detalleCompra.setId_unidad(rs.getString("und"));   
                detalleCompra.setCostoMayor(rs.getDouble("costo_mayor")); 
                 
            }  
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
                
            }
        }
        return detalleCompra;
    }

    @Override
    public boolean StockCompra(String id_compra) {
        
        boolean estado = false;
        Statement st = null;
        String query="BEGIN STOCK_COMPRA('"+id_compra+"'); END;";
        
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
    public boolean DeleteProdCompra(String id_compra, String id_producto) {
        
        boolean estado = false;
        Statement st = null;
        String query="delete from compra_detalle where id_compra='"+id_compra+"' and id_producto='"+id_producto+"'";
        
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
    public boolean UpdateDeompra(DetalleCompra dc) {
        
        boolean estado = false;
        Statement st = null;
        String query="update compra_detalle set id_unidad='"+dc.getId_unidad()+"',cant_mayor="+dc.getCantMayor()+
                    ",cant_menor="+dc.getCantMenor()+",costo_mayor="+dc.getCostoMayor()+
                    " where id_compra='"+dc.getId_compra()+"' and id_producto='"+dc.getId_producto()+"'";
        
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
    public boolean UpdateMoneda(TipoMoneda moneda) {
        
        boolean estado = false;
        Statement st = null;
        String query="update tipo_moneda set valor_actual="+moneda.getValorActual()
                + "where id_moneda='"+moneda.getIdMoneda()+"'";
        
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
    public List<Rep_compras> ListarCompraTotal(String f_in,String f_fn) {
        
        Statement st=null;
        ResultSet rs=null;
        String sql = "select id_compra, to_char(fecha_compra,'dd/mm/yyyy') as fecha_compra,nombre_comp(id_comprobante) as comprobante, "
                    + "num_comprobante,nombre_usuario(id_usuario) as usuario,nombre_proveedor(id_proveedor) as proveedor, "
                    + "nombre_tipo_moneda(id_moneda) as moneda, nombre_forma_pago(id_forma_pago) as fpago,igv from compra "
                    + "where fecha_compra between to_date('"+f_in+"','yyyy-mm-dd') and to_date('"+f_fn+"','yyyy-mm-dd') " 
                    + "order by fecha_compra asc";
        
        List<Rep_compras> lista= new ArrayList<Rep_compras>();
        Rep_compras rep_compras= null;
        try {
            st = open().createStatement();
            rs = st.executeQuery(sql);
            
            while (rs.next()) {                    
                rep_compras = new Rep_compras();              
                rep_compras.setId_compra(rs.getString("id_compra"));
                rep_compras.setFecha_compra(rs.getString("fecha_compra"));
                rep_compras.setNombre_comprobante(rs.getString("comprobante"));
                rep_compras.setNum_com(rs.getString("num_comprobante")); 
                rep_compras.setNombre_usuario(rs.getString("usuario")); 
                rep_compras.setNombre_proveedor(rs.getString("proveedor")); 
                rep_compras.setNombre_tipo_moneda(rs.getString("moneda")); 
                rep_compras.setNombre_forma_pago(rs.getString("fpago")); 
                rep_compras.setIgv(rs.getString("igv"));
                lista.add(rep_compras);
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
    public boolean UpdateCompra(Compra compra) {
        
        boolean estado = false;
        Statement st = null;
        String query="update compra set id_usuario='"+compra.getId_usuario()+"', "
                    + "id_proveedor='"+compra.getId_proveedor()+"', "
                    + "id_moneda='"+compra.getId_tipoMoneda()+"', "
                    + "id_comprobante='"+compra.getId_comprobante()+"', "
                    + "id_forma_pago='"+compra.getId_formaPago()+"', "
                    + "valor_moneda=valor_mon('"+compra.getId_tipoMoneda()+"'), "
                    + "igv="+compra.getIgv()+", "
                    + "flete="+compra.getFlete()
                    + " where id_compra='"+compra.getId_compra()+"'";
        
        try {
            st = open().createStatement();
            st.executeUpdate(query);
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

    
    
}
