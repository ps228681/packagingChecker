using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace PackagingChecker {
    public class Product : INotifyPropertyChanged {
        private string _name;
        private int _quantity;
        private int _height;
        private int _width;
        private int _length;

        public string Name {
            get => _name;
            set {
                if (_name != value) {
                    _name = value;
                    OnPropertyChanged();
                }
            }
        }

        public int Quantity {
            get => _quantity;
            set {
                if (_quantity != value) {
                    _quantity = value;
                    OnPropertyChanged();
                    OnPropertyChanged(nameof(QuantityText));
                }
            }
        }

        public int Height {
            get => _height;
            set {
                if (_height != value) {
                    _height = value;
                    OnPropertyChanged();
                }
            }
        }

        public int Width {
            get => _width;
            set {
                if (_width != value) {
                    _width = value;
                    OnPropertyChanged();
                }
            }
        }

        public int Length {
            get => _length;
            set {
                if (_length != value) {
                    _length = value;
                    OnPropertyChanged();
                }
            }
        }

        public string Dimensions => $"{Length / 10}cm x {Width / 10}cm x {Height / 10}cm";

        public string QuantityText => $"{Quantity}x";

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null) {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}