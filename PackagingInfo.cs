namespace PackagingChecker;

public class PackagingInfo {
    public string Name { get; set; }
    public int Price { get; set; }
    
    public PackagingInfo(string name, int price) {
        Name = name;
        Price = price;
    }
}