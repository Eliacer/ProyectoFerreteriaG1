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
import javax.servlet.http.HttpSession;
import proy01.modelo.dao.VentaDao;
import proy01.modelo.daoImpl.VentaDaoImpl;
import proy01.modelo.entidad.Venta;

/**
 *
 * @author Eliacer Fernandez
 */
public class Ventas extends HttpServlet {

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
        
    String id_config=request.getParameter("id_configuracion");
    String id_user=request.getParameter("id_user");
    String id_cliente=request.getParameter("id_cliente");
    String num_comp="";
    
    HttpSession session1 = request.getSession();
    String id_venta=(String)session1.getAttribute("id_venta");
    
    Venta venta = new Venta();
    VentaDao dao = new VentaDaoImpl();
    
        if (id_config!=null &&id_user!=null &&id_cliente!=null) {
            venta=dao.ObtenerNumComp(id_user, id_cliente, id_config);
            num_comp=venta.getNumComprobante();
            
            if (num_comp!=null) {
                venta =dao.ObtenerVenta(num_comp, id_config);
                
                HttpSession session = request.getSession();
                session.setAttribute("id_venta", venta.getId_venta());
                session.setAttribute("id_cliente", venta.getId_cliente());
                session.setAttribute("serie", venta.getSerie());
                session.setAttribute("num_comp", venta.getNumComprobante());
                session.setAttribute("fecha_venta", venta.getFechaventa());
                
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
            }
            
        } else {
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
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
