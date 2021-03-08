<?php
header('Content-Type: application/json; charset=utf-8');

session_start();
include_once '../../../_classes/start.php';
$json = new JSON();

if (!(isset($_SESSION['usuario']) && $_SESSION['usuario'] != ""))
{
	// não há sessão
	$json->setStatus("redir");
}
else
{
	// login já realizado
	try
	{
		$tpl = new Template("../../view/html/individuoMedicamento.html");

		// busca permissão de acordo com cada menu clicado e habilita o CRUD definido no BD
		include_once ("../../../_classes/permissaoTela.php");

		$opcoes = "";
		$result = PublicMedicamento::consultarMedicamentos();
		if (!empty($result)) {
			foreach ($result as $linha) {
				$opcoes .= $linha["id"] . ":" . $linha["nome"] . ";";
			}
			$opcoes = substr($opcoes, 0, -1);
		}
		$tpl->OPTIONS_MEDICAMENTO = "'" . $opcoes . "'";
		
		$json->setStatus("ok");
		$json->setObjeto( $tpl->parse() );
	}
	catch (Exception $ex)
	{
		$json->setStatus("erro");
		$json->setMensagem($ex->getMessage());
	}
}

$json->imprimirJSON();