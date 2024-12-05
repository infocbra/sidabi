<?php


class Database 
{
    protected static $db;

    private function __construct()
    {


        $db_driver = "pgsql";
        $db_host = "sidabi_db";
        $db_nome = "postgres";
        $db_port = 5432;
        $db_usuario = "postgres";
        $db_senha = "senha1";

        try
        {
            self::$db = new PDO("$db_driver:host=$db_host;port=$db_port;dbname=$db_nome", $db_usuario, $db_senha);
            self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            //self::$db->exec('SET NAMES utf8');
        }
        catch (PDOException $e)
        {
            die("Connection Error: " . $e->getMessage());
        }
    }
    
    public static function conexao()
    {
        if (!self::$db)
        {
            new Database();
        }
        return self::$db;
    }
}
