<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>

<%
    // Recuperamos los errores que puedan haber sido enviados desde el Servlet
    @SuppressWarnings("unchecked")
    Map<String, String> errores = (Map<String, String>) request.getAttribute("errores");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Usuario</title>
    <!-- Enlace a los estilos CSS personalizados -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Style.css" />
</head>
<body>

<h3>Registro de Usuario</h3>

<% if (errores != null && !errores.isEmpty()) { %>
<!-- Si hay errores de validación, los mostramos en una lista -->
<div class="alert">
    <ul>
        <% for (String err : errores.values()) { %>
        <li><%= err %></li>
        <% } %>
    </ul>
</div>
<% } %>

<form action="<%= request.getContextPath() %>/registro" method="post">
    <!-- Formulario principal que será procesado por el Servlet al enviarse -->

    <!-- Campo para ingresar el nombre de usuario -->
    <div class="form-group">
        <label for="username">Usuario:</label>
        <input type="text" name="username" id="username"
               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" />
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("username")){
                out.print("<div>"+ errores.get("username")+ "</div>");
            }
        %>
    </div>
    <!-- Campo para ingresar la contraseña (por seguridad no se prellena) -->
    <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" />
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("password")){
                out.print("<div>"+ errores.get("password")+ "</div>");
            }
        %>
    </div>

    <!-- Campo para ingresar un correo electrónico válido -->
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" name="email" id="email"
               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("email")){
                out.print("<div>"+ errores.get("email")+ "</div>");
            }
        %>
    </div>

    <!-- Menú desplegable para elegir un país -->
    <div class="form-group">
        <label for="pais">País:</label>
        <select name="pais" id="pais">
            <option value="">----- Seleccionar -----</option>
            <option value="ES" <%= "ES".equals(request.getParameter("pais"))?"selected":"" %>>España</option>
            <option value="EC" <%= "EC".equals(request.getParameter("pais"))?"selected":"" %>>Ecuador</option>
            <option value="PE" <%= "PE".equals(request.getParameter("pais"))?"selected":"" %>>Perú</option>
            <option value="CO" <%= "CO".equals(request.getParameter("pais"))?"selected":"" %>>Colombia</option>
            <option value="BR" <%= "BR".equals(request.getParameter("pais"))?"selected":"" %>>Brasil</option>
            <option value="AR" <%= "AR".equals(request.getParameter("pais"))?"selected":"" %>>Argentina</option>
            <option value="VE" <%= "VE".equals(request.getParameter("pais"))?"selected":"" %>>Venezuela</option>
        </select>
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("pais")){
                out.print("<div>"+ errores.get("pais")+ "</div>");
            }
        %>
    </div>

    <!-- Selección de lenguaje de programación preferido -->
    <div class="form-group">
        <label for="lenguajes">Lenguajes:</label>
        <select name="lenguajes" id="lenguajes">
            <option value="">-- Seleccionar --</option>
            <option value="Java" <%= "Java".equals(request.getParameter("lenguajes"))?"selected":"" %>>Java</option>
            <option value="Python" <%= "Python".equals(request.getParameter("lenguajes"))?"selected":"" %>>Python</option>
            <option value="C#" <%= "C#".equals(request.getParameter("lenguajes"))?"selected":"" %>>C#</option>
            <option value="C++" <%= "C++".equals(request.getParameter("lenguajes"))?"selected":"" %>>C++</option>
            <option value="Angular" <%= "Angular".equals(request.getParameter("lenguajes"))?"selected":"" %>>Angular</option>
        </select>
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("lenguajes")){
                out.print("<div>"+ errores.get("lenguajes")+ "</div>");
            }
        %>
    </div>

    <!-- Sección con checkboxes para asignar uno o más roles -->
    <div class="form-group roles">
        <label>Roles:</label>
        <label><input type="checkbox" name="roles" value="ROLE_ADMIN"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_ADMIN"))?"checked":"" %> /> Administrador</label>

        <label><input type="checkbox" name="roles" value="ROLE_USER"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_USER"))?"checked":"" %> /> Usuario</label>

        <label><input type="checkbox" name="roles" value="ROLE_MODERADOR"
                <%= (request.getParameterValues("roles")!=null && java.util.Arrays.asList(request.getParameterValues("roles")).contains("ROLE_MODERADOR"))?"checked":"" %> /> Moderador</label>
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("roles")){
                out.print("<div>"+ errores.get("roles")+ "</div>");
            }
        %>
    </div>
    <!-- Radios para escoger idioma preferido -->
    <div class="form-group idiomas">
        <label>Idiomas:</label>
        <label><input type="radio" name="idioma" value="es" <%= "es".equals(request.getParameter("idioma"))?"checked":"" %> /> Español</label>
        <label><input type="radio" name="idioma" value="en" <%= "en".equals(request.getParameter("idioma"))?"checked":"" %> /> Inglés</label>
        <label><input type="radio" name="idioma" value="ru" <%= "ru".equals(request.getParameter("idioma"))?"checked":"" %> /> Ruso</label>
    </div>
    <div>
        <%
            if(errores != null && errores.containsKey("idioma")){
                out.print("<div>"+ errores.get("idioma")+ "</div>");
            }
        %>
    </div>

    <!-- Checkbox adicional para activar alguna opción especial -->
    <div class="form-group">
        <label><input type="checkbox" name="habilitar" id="habilitar"
                <%= request.getParameter("habilitar")!=null?"checked":"" %> /> Habilitar</label>
    </div>


    <!-- Campo oculto que se envía sin que el usuario lo vea -->
    <input type="hidden" name="secreto" value="123456" />

    <!-- Botón que envía el formulario al servidor -->
    <div class="form-group submit">
        <button type="submit">Enviar</button>
    </div>
</form>

</body>
</html>