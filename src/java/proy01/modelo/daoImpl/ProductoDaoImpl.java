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
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.entidad.Producto;
import proy01.modelo.entidad.Rep_Inventario;


/**
 *
 * @author Eliacer Fernandez
 */
public class ProductoDaoImpl implements ProductoDao{

    public Connection open(){
        return ConectarOracle.conectar();
    }
    
    @Override
    public boolean InsertProducto(Producto producto) {
        
        boolean estado = false;
        Statement st = null;
        String query = "insert into producto "
                + "(codigo, "
                + " nombre, "
                + " id_unidad_medida, "
                + " porc_ganancia, "
                + " id_categoria, "
                + " id_marca, "
                + " id_ubicacion, "
                + " descripcion) "
                + " values ("+"'"+producto.getCodigo()
                +"','" +producto.getNombre()
                +"','" +producto.getIdUndMedida()
                +"', " +producto.getPorc_ganacia()
                +",'" +producto.getId_categoria()
                +"','" +producto.getId_marca()
                +"','" +producto.getId_ubicacion()
                +"','" +producto.getDescripcion()+"')";

        try {
            st = open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado=false;
            } catch (Exception ex) {
            }
        }
        
        return estado;
    }
    
    @Override
    public Producto ObtenerProducto (String id_producto)
    {
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from producto where id_producto='"+id_producto+"'";
        Producto pr = null;
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                pr= new Producto();
                pr.setIdProducto(rs.getString("id_producto"));
                pr.setCodigo(rs.getString("codigo"));
                pr.setNombre(rs.getString("nombre"));
                pr.setIdUndMedida(rs.getString("id_unidad_medida"));
                pr.setPorc_ganacia(rs.getDouble("porc_ganancia"));
                pr.setPrecio(rs.getDouble("precio"));
                pr.setStock_actual(rs.getInt("stock_actual"));
                pr.setFecha_reg(rs.getString("fecha_reg"));
                pr.setId_categoria(rs.getString("id_categoria"));
                pr.setId_marca(rs.getString("id_marca"));
                pr.setId_ubicacion(rs.getString("id_ubicacion"));
                pr.setDescripcion(rs.getString("descripcion"));              
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
    return pr;
    }
    @Override
    public boolean DeleteProducto(String id) {
        boolean estado = false;
        Statement st=null;
        String query="delete from producto where id_producto='"+id+"'";  
        try {
            st= open().createStatement();
            st.executeUpdate(query);
            open().commit();
            open().close();
            estado=true;
            
        } catch (Exception e) {
            e.printStackTrace();
            estado=false;
       try {
                open().rollback();
                open().close();                  
            } catch (Exception ex) {
            }
        }
        
        return estado;
    }

    @Override
    public boolean UpdateProducto(Producto producto) {
        
        boolean estado = false;
        Statement st = null;
        String query = "update producto set "
                +"  codigo=upper('"+producto.getCodigo()
                +"'),nombre=upper('"+producto.getNombre()
                +"'),id_unidad_medida='"+producto.getIdUndMedida()
                +"',porc_ganancia="+producto.getPorc_ganacia()
                +",id_categoria='"+producto.getId_categoria()
                +"',id_marca='"+producto.getId_marca()
                +"',id_ubicacion='"+producto.getId_ubicacion()
                +"',descripcion='"+producto.getDescripcion()
                +"' where id_producto='"+producto.getIdProducto()+"'";
       
        try {
            st = open().createStatement();
            st.executeQuery(query);
            open().commit();
            open().close();
            estado=true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().rollback();
                open().close();
                estado=false;
            } catch (Exception ex) {
            }
        }
        
        return estado;
    }

    @Override
    public List<Producto> BuscarProducto(String Buscar_por, String Buscar) {
        
        List<Producto> lista = new ArrayList<Producto>();
        Statement st = null;
        ResultSet rs = null;
        Producto producto = null;
        String query = "select p.id_producto as id_producto,p.nombre ||' '||upper(m.nombre_marca) as nombre, "
                     + "um.abreviatura as id_um,p.precio as precio, p.stock_actual as stock, "
                     + "u.nombre_ubicacion as ubicacion "
                     + "from producto p, marca m, ubicacion u,unidad_medida um "
                     + "where m.id_marca=nvl(p.id_marca,'00001') and "
                     + "u.id_ubicacion=nvl(p.id_ubicacion,'00001') and um.id_unidad_medida=p.id_unidad_medida and "
                     + "upper(p."+Buscar_por+") like upper('%"+Buscar+"%') "
                     + "and rownum <=8 "
                     + "order by nombre asc";   
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                producto = new Producto();
                producto.setIdProducto(rs.getString("id_producto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setIdUndMedida(rs.getString("id_um"));           
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock_actual(rs.getInt("stock"));           
                producto.setId_ubicacion(rs.getString("ubicacion"));
                lista.add(producto);      
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
    public Producto ObtenerDatProducto(String id_pro) {
        
        Statement st = null;
        ResultSet rs= null;
        String query = "select stock_actual,nombre,nombre_marca(id_marca)as marca,precio from producto "
                    + "where id_producto='"+id_pro+"'";
        Producto pr = null;
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                pr= new Producto();
                pr.setNombre(rs.getString("nombre"));
                pr.setId_marca(rs.getString("marca"));
                pr.setPrecio(rs.getDouble("precio"));
                pr.setStock_actual(rs.getInt("stock_actual"));
            }
            open().close();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                open().close();
            } catch (Exception ex) {
            }
        }
    return pr;
    
    }

    @Override
    public List<Rep_Inventario> ListarInventProducto() {
        
        List<Rep_Inventario> lista = new ArrayList<Rep_Inventario>();
        Statement st = null;
        ResultSet rs = null;
        Rep_Inventario producto = null;
        String query = "select id_producto,nombre_producto(id_producto) as producto,stock_actual, trunc(costo_promedio(id_producto),2) as costo, "
                     + "trunc(precio_promedio(id_producto),2) as precio, "
                     + "trunc(porcentaje_utilidad(id_producto),2) as utilidad from producto order by producto asc";
        
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                producto = new Rep_Inventario();
                producto.setId_producto(rs.getString("id_producto"));
                producto.setProducto(rs.getString("producto"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock_actual(rs.getInt("stock_actual"));           
                producto.setCosto(rs.getDouble("costo"));
                producto.setUtilidad(rs.getDouble("utilidad"));
                lista.add(producto);      
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
    public List<Producto> ProductosPotencia() {
        
        List<Producto> lista = new ArrayList<Producto>();
        Statement st = null;
        ResultSet rs = null;
        Producto producto = null;
        String query = "select * from ( select distinct p.nombre as producto,nombre_marca(p.id_marca) as marca, "
                    + "trunc(monto_producto(p.id_producto),2) as monto "
                    + "from venta_detalle vd, producto p where p.id_producto=vd.id_producto order by monto desc) "
                    + "where rownum<=4";  
      
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                producto = new Producto();
                producto.setNombre(rs.getString("producto"));
                producto.setId_marca(rs.getString("marca"));
                producto.setPrecio(rs.getDouble("monto"));
                lista.add(producto);      
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
