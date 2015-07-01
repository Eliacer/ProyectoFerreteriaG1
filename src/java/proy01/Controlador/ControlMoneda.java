/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import proy01.modelo.dao.CompraDao;
import proy01.modelo.daoImpl.CompraDaoImpl;
import proy01.modelo.entidad.TipoMoneda;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlMoneda extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String opcion=request.getParameter("opcion"); opcion = opcion == null?"" : opcion;
        String mensaje=request.getParameter("mensaje"); mensaje = mensaje == null?"" : mensaje;
        String id_moneda=request.getParameter("id_moneda"); id_moneda = id_moneda == null?"" : id_moneda;
        String nombre_moneda=request.getParameter("nombre_moneda"); nombre_moneda = nombre_moneda == null?"" : nombre_moneda;
        String valor_actual=request.getParameter("valor_actual"); valor_actual = valor_actual == null?"" : valor_actual;
        String abrev=request.getParameter("abrev"); abrev = abrev == null?"" : abrev;
        String alert="";
        
        TipoMoneda moneda = new TipoMoneda();
        CompraDao dao = new CompraDaoImpl();
        switch(opcion){
            
            case "Iniciar":
                request.setAttribute("listar", dao.ListarMoneda());
                request.getRequestDispatcher("FijarMoneda.jsp").forward(request, response);
                break;
                
            case "Agregar":
                request.setAttribute("opcion", "Registrar");
                request.getRequestDispatcher("RegistrarMoneda.jsp").forward(request, response);
                break;
            case "Registrar":
                
                moneda.setIdMoneda(id_moneda);
                moneda.setNombre(nombre_moneda);
                moneda.setAbrev(abrev);
                moneda.setValorActual(Double.parseDouble(valor_actual));
                if (dao.AgregarMoneda(moneda)) {
                    alert="success";
                    mensaje="Se inserto correctamente...";
                } else {
                    alert="danger";
                    mensaje="Ocurrio un error al insertar...";
                }
                request.setAttribute("listar", dao.ListarMoneda());
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("FijarMoneda.jsp").forward(request, response);
                break;
                
            case "Actualizar":
                request.setAttribute("opcion", "Actualizando");
                request.setAttribute("Moneda",dao.BuscarMonedaid(id_moneda));
                request.getRequestDispatcher("RegistrarMoneda.jsp").forward(request, response);
                break;
                
            
            case "Actualizando":
                
                moneda.setIdMoneda(id_moneda);
                moneda.setNombre(nombre_moneda);
                moneda.setAbrev(abrev);
                moneda.setValorActual(Double.parseDouble(valor_actual));
                if (dao.ActualizarMoneda(moneda)) {
                    alert="success";
                    mensaje="Se actualizo correctamente";
                } else {
                    alert="danger";
                    mensaje="Ocurrio un error al actualizar";
                }
                
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("opcion", opcion);
                request.setAttribute("listar", dao.ListarMoneda());
                request.getRequestDispatcher("FijarMoneda.jsp").forward(request, response);
                
                break;              
                
            case "Eliminar":
                if (dao.EliminarMoneda(id_moneda)) {
                    alert="success";
                    mensaje="Se elimino correctamente...";
                } else {
                    alert="danger";
                    mensaje="¡¡No se puede eliminar...Es posible que se este usando este dato..!!";
                }
                
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("listar", dao.ListarMoneda());
                request.getRequestDispatcher("FijarMoneda.jsp").forward(request, response);
                
                break;
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
