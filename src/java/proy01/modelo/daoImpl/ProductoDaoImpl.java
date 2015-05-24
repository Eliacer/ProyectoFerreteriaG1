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
                + " unidad_medida, "
                + " medida, "
                + " precio_publico, "
                + " precio_mayor, "
                + " precio_credito, "
                + " id_categoria, "
                + " id_marca, "
                + " id_ubicacion, "
                + " color, "
                + " descripcion, "
                + " id_unidad, "
                + " cantidad, "
                + " p_compra, "
                + " porc_publico, "
                + " porc_mayor, "
                + " porc_cred, "
                + " igv, "
                + " flete) "
                + " values ("+"'"+producto.getCodigo()
                +"','" +producto.getNombre()
                +"','" +producto.getUndMedida()
                +"','" +producto.getMedida()
                +"', " +producto.getPrecioPublico()
                +" , " +producto.getPrecioMayor()
                +" , " +producto.getPrecioCredito()    
                +" ,'" +producto.getId_categoria()
                +"','" +producto.getId_marca()
                +"','" +producto.getId_ubicacion()
                +"','" +producto.getColor()              
                +"','" +producto.getDescripcion()
                +"','" +producto.getId_unidad()
                +"', " +producto.getCantidad()
                +" , " +producto.getPrecioCompra()
                +" , " +producto.getPorc_pub()
                +" , " +producto.getPorc_mayor()
                +" , " +producto.getPorc_cred()
                +" , " +producto.getIgv()
                +" , " +producto.getFlete()+")";

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
    public List<Producto> ObtenerProducto (String id_producto)
    {
        Statement st = null;
        ResultSet rs= null;
        String query = "select * from producto where id_producto='"+id_producto+"'";
        Producto pr = null;
        List<Producto> lista = new ArrayList<Producto>();
        
        try {
            st = open().createStatement();
            rs=st.executeQuery(query);          
            while (rs.next()) {
                pr= new Producto();
                pr.setIdProducto(rs.getString("id_producto"));
                pr.setCodigo(rs.getString("codigo"));
                pr.setNombre(rs.getString("nombre"));
                pr.setUndMedida(rs.getString("unidad_medida"));
                pr.setMedida(rs.getString("medida"));
                pr.setFechaReg(rs.getString("fecha_reg"));
                pr.setPrecioPublico(rs.getDouble("precio_publico"));
                pr.setPrecioMayor(rs.getDouble("precio_mayor"));
                pr.setPrecioCredito(rs.getDouble("precio_credito"));
                pr.setId_categoria(rs.getString("id_categoria"));
                pr.setId_marca(rs.getString("id_marca"));
                pr.setId_ubicacion(rs.getString("id_ubicacion"));
                pr.setColor(rs.getString("color"));
                pr.setDescripcion(rs.getString("descripcion"));   
                pr.setId_unidad(rs.getString("id_unidad")); 
                pr.setCantidad(rs.getString("cantidad")); 
                pr.setPrecioCompra(rs.getDouble("p_compra"));  
                pr.setPorc_pub(rs.getDouble("porc_publico")); 
                pr.setPorc_mayor(rs.getDouble("porc_mayor")); 
                pr.setPorc_cred(rs.getDouble("porc_cred")); 
                pr.setIgv(rs.getDouble("igv"));
                pr.setFlete(rs.getDouble("flete"));
                lista.add(pr);
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
                +"  codigo='"+producto.getCodigo()
                +"',nombre='"+producto.getNombre()
                +"',unidad_medida='"+producto.getUndMedida()
                +"',medida='"+producto.getMedida()
                +"',porc_publico="+producto.getPorc_pub()
                +" ,porc_mayor="+producto.getPorc_mayor()
                +" ,porc_cred="+producto.getPorc_cred()
                +" ,id_categoria='"+producto.getId_categoria()
                +"',id_marca='"+producto.getId_marca()
                +"',id_ubicacion='"+producto.getId_ubicacion()
                +"',color='"+producto.getColor()
                +"',descripcion='"+producto.getDescripcion()
                +"',id_unidad='"+producto.getId_unidad()
                +"',cantidad="+producto.getCantidad()
                +" ,p_compra="+producto.getPrecioCompra()
                +" ,precio_publico="+producto.getPrecioPublico()
                +" ,precio_mayor="+producto.getPrecioMayor()
                +" ,precio_credito="+producto.getPrecioCredito()
                +" ,igv="+producto.getIgv()
                +" ,flete="+producto.getFlete()
                +" where id_producto='"+producto.getIdProducto()+"'";
       
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
        String query = "select p.id_producto as id_producto,p.nombre||' ('||m.nombre_marca||')' as nombre, "
                     + "round(p.precio_publico,2) as precio_publico, round(p.precio_mayor,2) as precio_mayor, "
                     + "round(p.precio_credito,2) as precio_credito, u.nombre_ubicacion as ubicacion "
                     + "from producto p, marca m, ubicacion u "
                     + "where m.id_marca=nvl(p.id_marca,'00007') and "
                     + "u.id_ubicacion=nvl(p.id_ubicacion,'00006') and "
                     + "upper(p."+Buscar_por+") like upper('%"+Buscar+"%') "
                     + "and rownum <=10 "
                     + "order by nombre asc";   
        try {
            st = open().createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) { 
                producto = new Producto();
                producto.setIdProducto(rs.getString("id_producto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecioMayor(rs.getDouble("precio_mayor"));
                producto.setPrecioPublico(rs.getDouble("precio_publico"));
                producto.setPrecioCredito(rs.getDouble("precio_credito"));
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
    
    
    
    
}
