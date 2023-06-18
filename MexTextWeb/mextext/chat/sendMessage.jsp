<jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>
<jsp:setProperty name="SessionDB" property="content" value='<%=request.getParameter("content")%>'/>
<%
  SessionDB.sendMessage();
%>