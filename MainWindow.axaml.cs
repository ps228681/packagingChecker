using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using Avalonia;
using Avalonia.Controls;

namespace PackagingChecker
{
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        private const int SeederCount = 33;
        private readonly DatabaseConnector _dbConnector;
        private readonly PackagingChecker _packageFitter = new();
        private readonly bool _shouldSeed = false;

        public event PropertyChangedEventHandler PropertyChanged;

        private ObservableCollection<CustomerOrder> _orders;
        private ObservableCollection<Product> _productsInOrder;

        public ObservableCollection<CustomerOrder> Orders
        {
            get => _orders;
            set
            {
                if (_orders != value)
                {
                    _orders = value;
                    OnPropertyChanged(nameof(Orders));
                }
            }
        }

        public ObservableCollection<Product> ProductsInOrder
        {
            get => _productsInOrder;
            set
            {
                if (_productsInOrder != value)
                {
                    _productsInOrder = value;
                    OnPropertyChanged(nameof(ProductsInOrder));
                }
            }
        }

        public MainWindow()
        {
            InitializeComponent();
            DataContext = this;

            _dbConnector = new DatabaseConnector();

            LoadOrders();

            if (_shouldSeed)
            {
                SeedDatabase();
            }

            SideListBox.SelectedIndex = 0;
        }

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void LoadOrders()
        {
            try
            {
                Orders = new ObservableCollection<CustomerOrder>(_dbConnector.GetOrders());
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading orders: {ex.Message}");
            }
        }

        private void SeedDatabase()
        {
            try
            {
                _dbConnector.Seeder("order_items", SeederCount);
                _dbConnector.Seeder("orders", SeederCount);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error seeding database: {ex.Message}");
            }
        }

        private void SideListBox_OnSelectionChanged(object? sender, SelectionChangedEventArgs e)
        {
            if (SideListBox.SelectedItem is CustomerOrder selectedOrder)
            {
                try
                {
                    LoadProductsInOrder(selectedOrder.OrderId);
                    UpdateBestPackaging(selectedOrder.OrderId);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                }
            }
        }

        private void LoadProductsInOrder(int orderId)
        {
            var productsInOrderData = _dbConnector.GetProductsOfOrder(orderId);
            if (productsInOrderData == null)
            {
                Console.WriteLine("No data found for the selected order.");
                return;
            }

            var productsInOrder = new List<Product>();
            foreach (DataRow productRow in productsInOrderData.Rows)
            {
                productsInOrder.Add(new Product
                {
                    Name = (string)productRow["name"],
                    Quantity = (int)productRow["quantity"],
                    Length = (int)productRow["length"],
                    Width = (int)productRow["width"],
                    Height = (int)productRow["height"],
                });
            }

            ProductsInOrder = new ObservableCollection<Product>(productsInOrder);
            ProductsInOrderListBox.ItemsSource = ProductsInOrder;
        }

        private void UpdateBestPackaging(int orderId)
        {
            var result = _packageFitter.FindBestPackagingForOrder(orderId);
            if (result == null)
            {
                result = "No packaging found for this order.";
                bestPackagingText.Foreground = Avalonia.Media.Brushes.Red;
            }
            else
            {
                bestPackagingText.Foreground = Avalonia.Media.Brushes.White;
            }
            bestPackagingText.Text = result;
            Console.WriteLine($"Best packaging for order {orderId}: {result}");
        }
    }
}