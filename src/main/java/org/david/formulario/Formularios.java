package org.david.formulario;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet("/registro")
public class Formularios extends HttpServlet {

    /**
     * Este método se ejecuta cuando el usuario envía el formulario mediante POST.
     * Aquí validamos los datos y generamos una respuesta HTML.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Asegura que los caracteres especiales se procesen correctamente (UTF-8)
        req.setCharacterEncoding("UTF-8");

        // Estructura que guardará los errores detectados durante la validación
        Map<String, String> errores = new LinkedHashMap<>();

        // Recuperación de los campos enviados desde el formulario
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email    = req.getParameter("email");
        String pais     = req.getParameter("pais");
        String lenguaje = req.getParameter("lenguajes");
        String[] roles  = req.getParameterValues("roles");
        String idioma   = req.getParameter("idioma");
        String habil    = req.getParameter("habilitar"); // Este campo es opcional
        String secreto  = req.getParameter("secreto");   // Campo oculto

        // Verificamos que los campos requeridos no estén vacíos
        if (username == null || username.trim().isEmpty()) {
            errores.put("username", "Debe ingresar un nombre de usuario.");
        }
        if (password == null || password.trim().isEmpty()) {
            errores.put("password", "Debe ingresar una contraseña.");
        }
        if (email == null || email.trim().isEmpty()) {
            errores.put("email", "El campo de correo electrónico es obligatorio.");
        }
        if (pais == null || pais.trim().isEmpty()) {
            errores.put("pais", "Seleccione una opción válida para el país.");
        }
        if (lenguaje == null || lenguaje.trim().isEmpty()) {
            errores.put("lenguajes", "Debe elegir al menos un lenguaje.");
        }
        if (roles == null || roles.length == 0) {
            errores.put("roles", "Seleccione uno o más roles.");
        }
        if (idioma == null || idioma.trim().isEmpty()) {
            errores.put("idioma", "Indique el idioma preferido.");
        }

        // Si se detectan errores, reenviamos al formulario con los mensajes
        if (!errores.isEmpty()) {
            req.setAttribute("errores", errores);
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return; // Detenemos la ejecución aquí
        }

        // Si los datos son válidos, generamos una página HTML de confirmación
        resp.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = resp.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='es'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'/>");
            out.println("<title>Registro completado</title>");
            out.println("</head><body>");
            out.println("<h2>Datos registrados correctamente</h2>");

            // Mostramos los datos ingresados
            out.printf("<p><strong>Nombre de usuario:</strong> %s</p>%n", username);
            out.printf("<p><strong>Email:</strong> %s</p>%n", email);
            out.printf("<p><strong>País:</strong> %s</p>%n", pais);
            out.printf("<p><strong>Lenguaje seleccionado:</strong> %s</p>%n", lenguaje);
            out.printf("<p><strong>Roles asignados:</strong> %s</p>%n", String.join(", ", roles));
            out.printf("<p><strong>Idioma:</strong> %s</p>%n", idioma);
            out.printf("<p><strong>Habilitado:</strong> %s</p>%n", (habil != null ? "Sí" : "No"));

            out.println("</body></html>");
        }
    }

    /**
     * Este método responde a las solicitudes GET. Redirecciona al formulario inicial.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // En lugar de mostrar directamente algo, redirigimos al formulario (index.jsp)
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}