<%-- Retrieve the success message attribute --%>
<%
    String message = (String) session.getAttribute("successMessage");
    if (message != null) {%>
<script>
    alert("<%=message%>");
</script>
<%
        session.removeAttribute("successMessage");
    }
%>
<%-- Retrieve the error message attribute --%>
<%
    String error = (String) session.getAttribute("error");
    if (error != null) {%>
<script>
    alert("<%=error%>");
</script>
<%
        session.removeAttribute("error");
    }
%>

<%-- Retrieve the goodbye message attribute --%>
<%
    String bye = (String) request.getAttribute("goodbye");
    if (bye != null) {%>
<script>
    alert("<%=bye%>");
</script>
<%
        request.removeAttribute("goodbye");
    }
%>
<%-- Retrieve the error message attribute --%>
<%
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null) {%>
<script>
    alert("<%=errorMessage%>");
</script>
<%
        session.removeAttribute("errorMessage");
    }
%>
<%-- Retrieve the alert on available only works when car status is cancelled attribute --%>
<script>
    function showAlert() {
        alert("Available only works when car status is 'Cancelled'.");
    }
</script>