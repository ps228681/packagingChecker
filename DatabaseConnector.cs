using System;
using System.Collections.Generic;
using System.Data;
using MySql.Data.MySqlClient;

namespace PackagingChecker {
    public class DatabaseConnector {

        private const string ConnectionString =
            "server=localhost;user=john;database=HCpackaging;port=3306;password=pass";

        private static readonly Random RandomGenerator = new();

        public List<CustomerOrder> GetOrders() {
            const string getOrdersQuery = @"
                SELECT 
                    orders.id AS order_id,
                    orders.order_time,
                    orders.customer_name,
                    SUM(order_items.quantity) AS total_quantity
                FROM 
                    order_items
                INNER JOIN 
                    orders ON order_items.order_id = orders.id
                GROUP BY 
                    orders.id, orders.order_time, orders.customer_name;";

            using (var connection = new MySqlConnection(ConnectionString)) {
                connection.Open();
                return ExecuteOrderQuery(connection, getOrdersQuery);
            }
        }

        private List<CustomerOrder> ExecuteOrderQuery(MySqlConnection connection, string query) {
            var orderList = new List<CustomerOrder>();

            using (var cmd = new MySqlCommand(query, connection)) {
                using (var reader = cmd.ExecuteReader()) {
                    while (reader.Read()) {
                        var order = new CustomerOrder {
                            OrderId = reader.GetInt32("order_id"),
                            AmountOfProducts = reader.GetInt32("total_quantity"),
                            OrderDate = reader.GetDateTime("order_time")
                        };
                        orderList.Add(order);
                    }
                }
            }

            return orderList;
        }

        public DataTable GetProductsOfOrder(int orderId) {
            const string query = @"
                SELECT order_items.quantity, products.* 
                FROM order_items 
                INNER JOIN products ON order_items.product_id = products.id 
                WHERE order_items.order_id = @orderId";

            using (var connection = new MySqlConnection(ConnectionString)) {
                connection.Open();
                using (var cmd = new MySqlCommand(query, connection)) {
                    cmd.Parameters.AddWithValue("@orderId", orderId);
                    return ExecuteQuery(cmd);
                }
            }
        }

        public DataTable GetPackagings() {
            const string query = "SELECT * FROM packagings";

            using (var connection = new MySqlConnection(ConnectionString)) {
                connection.Open();
                using (var cmd = new MySqlCommand(query, connection)) {
                    return ExecuteQuery(cmd);
                }
            }
        }

        private DataTable ExecuteQuery(MySqlCommand cmd) {
            var resultTable = new DataTable();

            using (var reader = cmd.ExecuteReader()) {
                resultTable.Load(reader);
            }

            return resultTable;
        }

        public bool Seeder(string table, int amount) {
            for (int i = 0; i < amount; i++) {
                string seedQuery = table switch {
                    "orders" =>
                        $"INSERT INTO orders(order_time, customer_name) VALUES('2024-01-01 12:00:00', 'Customer{i}')",
                    "order_items" =>
                        $"INSERT INTO order_items(order_id, product_id, quantity) VALUES({RandomNum(1, 70)}, {RandomNum(1, 50)}, {RandomNum(1, 12)})",
                    _ => throw new ArgumentException("Invalid table name")
                };

                ExecuteQuery(new MySqlCommand(seedQuery, new MySqlConnection(ConnectionString)));
            }

            return true;
        }

        private int RandomNum(int min, int max) {
            return RandomGenerator.Next(min, max + 1);
        }
    }
}