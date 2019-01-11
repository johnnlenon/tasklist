<%@page import="sun.net.smtp.SmtpClient"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import='java.io.*' %>
<%@ page import='java.sql.*' %>
<%
	Class.forName("com.mysql.jdbc.Driver");

	Connection connect = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/tasklist?user=root&password=123456");
	
	String nTask = request.getParameter("nTask");
	
	if(nTask == null){
		nTask = "listTask";
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TaskList</title>
</head>
<body>
<div class="container">
	<form action="#" method="post">
	<%
		if(nTask.equals("saveNew")){
			String titulo = request.getParameter("titulo");
			String descricao = request.getParameter("descricao");
			String status = request.getParameter("status");
			String data_criacao = request.getParameter("data_criacao");
			String data_edicao = request.getParameter("data_edicao");
			String data_conclusao = request.getParameter("data_conclusao");
			
			if(titulo != null && descricao != null && status != null && data_criacao != null && data_edicao != null && data_conclusao !=null){
				String sql = "INSERT INTO tasks (task_titulo, task_descricao, task_status, task_data_criacao, task_data_edicao, task_data_conclusao) VALUES (?,?,?,?,?,?)";
				PreparedStatement stmt = (PreparedStatement) connect.prepareStatement(sql);
				stmt.setString(1, titulo);
				stmt.setString(2, descricao);
				stmt.setString(3, status);
				stmt.setString(4, data_criacao);
				stmt.setString(5, data_edicao);
				stmt.setString(6, data_conclusao);
				stmt.execute();
				out.println("<b>Task "+ titulo +" inserido com sucesso!</b>");
				nTask = "listTask";
			}else{
				nTask = "newTask";
				out.println("<b>Todos os campos devem ser preenchidos</b>");
			}
		}
	
		if(nTask.equals("newTask")){
	%>
		<fieldset style="padding-top:40px;">
		
		  <div class="form-group">
		    <label for="titulo">Título</label>
		    <input type="text" class="form-control" name="titulo">
		  </div>
		  <div class="form-group">
		    <label for="descricao">Descrição</label>
		    <input type="text" class="form-control" name="descricao">
		  </div>
		  <div class="form-group">
		    <label for="status">Status</label>
		    <select class="form-control" name="status">
		      <option>CONCLUÍDO</option>
		      <option>ABERTO</option>
		    </select>
		  </div>
		  <div class="form-group">
		    <label for="data_criacao">Data de Criação</label>
		    <input type="date" class="form-control" name="data_criacao">
		  </div>
		  <div class="form-group">
		    <label for="data_edicao">Data de Edição</label>
		    <input type="date" class="form-control" name="data_edicao">
		  </div>
		  <div class="form-group">
		    <label for="data_conclusao">Data de Conclusão</label>
		    <input type="date" class="form-control" name="data_conclusao">
		  </div>
			<button class="btn btn-primary" type="submit" name="nTask" value="listTask"> << Voltar</button>
			<button class="btn btn-success" type="submit" name="nTask" value="saveNew">Salvar</button>
		</fieldset>
		<% } else if(nTask.equals("listTask")){%>
		<fieldset>
			<br>
			<button class="btn btn-success" type="submit" name="nTask" value="newTask">New Task</button>
			<br>
			<br>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Título</th>
						<th>Descrição</th>
						<th>Status</th>
						<th>Data de Criação</th>
						<th>Data de Edição</th>
						<th>Data de Conclusão</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					
					<%
						Statement s = connect.createStatement();
						ResultSet res = s.executeQuery("SELECT * from tasks");
						while (res.next()){
							out.print("<tr>");
								out.print("<td>"+res.getString("task_titulo")+"</td>");
								out.print("<td>"+res.getString("task_descricao")+"</td>");
								out.print("<td>"+res.getString("task_status")+"</td>");
								out.print("<td>"+res.getString("task_data_criacao")+"</td>");
								out.print("<td>"+res.getString("task_data_edicao")+"</td>");
								out.print("<td>"+res.getString("task_data_conclusao")+"</td>");
								out.print("<td>"+res.getString("task_id")+"</td>");
								out.print("<td>"+"<button class='btn btn-danger' type='submit' name='deletar' value='deletar'>Excluir</button>"+"</td>");
								out.print("<td>"+"<button class='btn btn-primary' type='submit' name='editar' value='editar'>Editar</button>"+"</td>");
							out.print("</tr>");
						}
					
					%>
					
				</tbody>
			</table>
		</fieldset>
		<% } %>
	</form>
	</div>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>