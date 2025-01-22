using System;
using System.ComponentModel;

namespace PackagingChecker
{
    public class CustomerOrder : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        private int _orderId;
        private int _amountOfProducts;
        private DateTime _orderDate;

        public int OrderId
        {
            get => _orderId;
            set
            {
                if (_orderId != value)
                {
                    _orderId = value;
                    OnPropertyChanged(nameof(OrderId));
                    OnPropertyChanged(nameof(OrderName));
                }
            }
        }

        public int AmountOfProducts
        {
            get => _amountOfProducts;
            set
            {
                if (_amountOfProducts != value)
                {
                    _amountOfProducts = value;
                    OnPropertyChanged(nameof(AmountOfProducts));
                    OnPropertyChanged(nameof(OrderProductQuantity));
                }
            }
        }

        public DateTime OrderDate
        {
            get => _orderDate;
            set
            {
                if (_orderDate != value)
                {
                    _orderDate = value;
                    OnPropertyChanged(nameof(OrderDate));
                    OnPropertyChanged(nameof(OrderDateFormatted));
                }
            }
        }

        public string OrderName => $"Order #{_orderId}";
        public string OrderProductQuantity => $"Product quantity: {_amountOfProducts}";
        public string OrderDateFormatted => $"Order date: {_orderDate:yyyy-MM-dd HH:mm:ss}";

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}