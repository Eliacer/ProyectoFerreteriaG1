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

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlReportes extends HttpServlet {

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
        
        
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String f_in = request.getParameter("f_in");f_in = f_in == null ? "" : f_in;
        String f_fn = request.getParameter("f_fn");f_fn = f_fn == null ? "" : f_fn;
        
        switch(opcion){
            
            case "Inventario":
                request.getRequestDispatcher("Rep_Productos.jsp").forward(request, response);
                
                break;
            case "Fprecio":
                request.getRequestDispatcher("Compra.jsp").forward(request, response);
                
                break;    
                
            case "Welcome":
                request.getRequestDispatcher("bienvenida.jsp").forward(request, response);
                
                break;   
            
            case "Rcompras":
                request.getRequestDispatcher("Rep_Compras.jsp").forward(request, response);
                
                break;  
                
            case "Rventas":
                request.getRequestDispatcher("Rep_Ventas.jsp").forward(request, response);
                
                break;  
            case "RventasF":
                request.setAttribute("f_in", f_in);
                request.setAttribute("f_fn", f_fn);
                request.getRequestDispatcher("Rep_Ventas.jsp").forward(request, response);
                
                break; 
            case "RcomprasF":
                request.setAttribute("f_in", f_in);
                request.setAttribute("f_fn", f_fn);
                request.getRequestDispatcher("Rep_Compras.jsp").forward(request, response);
                
                break;
            
            case "RImportantes":
                request.getRequestDispatcher("Rep_Decisivos.jsp").forward(request, response);
                
                break; 
                
            default:break;
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
