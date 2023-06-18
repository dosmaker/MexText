<jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>
<%
  String latestMessage = SessionDB.searchMessage();
  response.setHeader("Cache-Control", "no-store");
  // Restituisci il contenuto HTML dei messaggi da visualizzare
  out.println(latestMessage);
%>