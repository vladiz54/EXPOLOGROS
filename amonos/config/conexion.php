<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
class Database
{
    private $host = "localhost";
    private $db_name = "amonos";
    private $username = "root";
    private $password = "";
    public $conn;
    public function getConnection()
    {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host={$this->host};dbname={$this->db_name};charset=utf8",
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $exception) {
            $this->conn = null;
            throw $exception;
        }
        return $this->conn;
    }
    public function getDbName()
    {
        return $this->db_name;
    }
}
?>
