/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.dao;

import java.util.List;
import proy01.modelo.entidad.Categoria;
import proy01.modelo.entidad.Marca;
import proy01.modelo.entidad.Ubicacion;
import proy01.modelo.entidad.UndMedida;
import proy01.modelo.entidad.Unidad;


/**
 *
 * @author Eliacer Fernandez
 */
public interface CaracteristicasProductoDao {
    
   public List<Marca> ListarMarca();
   public List<Categoria> ListarCategoria();
   public List<Ubicacion> ListarUbicacion();
   public List<UndMedida> ListarUniMedida();
   public List<Unidad> ListarUnidad();
   public boolean Add_Caracteristicas(String name,String dato);
   public double GenerarP_Publico(double p_compra, double p_pub, double igv, double flete);
   public double GenerarP_Mayor(double p_compra, double p_may, double igv, double flete);
   public double GenerarP_Credito(double p_compra, double p_cred, double igv, double flete);
   
   
   
   
}
