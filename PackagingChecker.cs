using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using CromulentBisgetti.ContainerPacking;
using CromulentBisgetti.ContainerPacking.Algorithms;
using CromulentBisgetti.ContainerPacking.Entities;

namespace PackagingChecker
{
    public class PackagingChecker
    {
        private readonly DatabaseConnector _dbConnector = new();
        private Dictionary<int, PackagingInfo> _packagingDictionary;
        private List<Container> _containers;
        private List<Item> _products;
        private DateTime lastUpdate;

        public string FindBestPackagingForOrder(int orderId)
        {
            UpdatePackagingsList(); // update the packaging list if needed
            _products = GetProductsFromOrder(orderId); // get the products in the order

            if (_products == null || _products.Count == 0)
            {
                Console.WriteLine("No products found for the given order ID.");
                return "";
            }

            var results = PackProducts();
            string bestContainer = PickBestContainer(results);

            return bestContainer;
        }

        private void UpdatePackagingsList()
        {
            DateTime currentDate = DateTime.Now;
            DataTable table = null;

            // check if the last update was longer than 2 hours ago
            if (lastUpdate == null || (currentDate - lastUpdate).TotalHours > 2)
            {
                // update the packagings list
                GetPackagings();
                lastUpdate = currentDate;
            }
        }

        private void GetPackagings()
        {
            var packagingsTable = _dbConnector.GetPackagings();

            if (_containers == null || _packagingDictionary == null)
            {
                _containers = new List<Container>();
                _packagingDictionary = new Dictionary<int, PackagingInfo>();
            }
            else
            {
                _containers.Clear();
                _packagingDictionary.Clear();
            }

            foreach (DataRow row in packagingsTable.Rows)
            {
                // create a container object
                _containers.Add(new Container(
                    width: (int)row["width"],
                    height: (int)row["height"],
                    length: (int)row["length"],
                    id: (int)row["id"]
                ));

                // store the values as key-value pair for later reference
                _packagingDictionary.Add((int)row["id"],
                    new PackagingInfo(name: (string)row["name"], price: (int)row["purchase_price"]));
            }
        }

        private List<Item> GetProductsFromOrder(int orderId)
        {
            var productsTable = _dbConnector.GetProductsOfOrder(orderId);
            var products = new List<Item>();

            foreach (DataRow row in productsTable.Rows)
            {
                for (int i = 0; i < (int)row["quantity"]; i++)
                {
                    products.Add(new Item(
                        id: (int)row["id"],
                        dim1: (int)row["length"],
                        dim2: (int)row["width"],
                        dim3: (int)row["height"],
                        quantity: 1
                    ));
                }
            }

            return products;
        }

        private List<ContainerPackingResult> PackProducts()
        {
            // create a list for storing the results of the packing algorithm
            var results = new List<ContainerPackingResult>();

            // select an algorithm to use
            var algorithms = new List<int> { (int)AlgorithmType.EB_AFIT };

            // use the algorithm to fit the products inside the packages
            results = PackingService.Pack(_containers, _products, algorithms);

            return results;
        }

        private string PickBestContainer(List<ContainerPackingResult> results)
        {
            // search all the containers that could fit all the products
            var possibleContainers = results
                .Where(result => result.AlgorithmPackingResults[0].IsCompletePack)
                .ToList();

            // when no package could fit all the products
            if (possibleContainers.Count == 0)
            {
                Console.WriteLine("No complete container found.");
                return null;
            }

            // when there is only one possible packaging
            if (possibleContainers.Count == 1)
            {
                // get the name of the container
                var containerName = _packagingDictionary[possibleContainers[0].ContainerID].Name;
                return containerName;
            }

            // get the prices of the packagings
            var containerPrices = possibleContainers
                .ToDictionary(container => container.ContainerID,
                    container => _packagingDictionary[container.ContainerID].Price);

            // sort the list on price and pick the cheapest packaging
            var bestContainer = containerPrices
                .OrderBy(pair => pair.Value)
                .First()
                .Key;

            // get the name of the packaging
            var bestContainerName = _packagingDictionary[bestContainer].Name;

            return bestContainerName;
        }
    }
}