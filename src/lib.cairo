#[derive(Drop)]
enum CoffeeType{
    Americano,
    Espresso,
    Latte,
    Cappucino
}

#[derive(Drop)]
enum CoffeeSize{
    Small,
    Medium,
    Large
}

// Coffee ingredients
#[derive(Drop)]
struct Stock{
    milk: u32,
    coffee_beans: u32
}

trait PriceTrait{
    // Self is used when the function is part of the trait implementation
    fn calculate_price(self: @CoffeeType, size: @CoffeeSize) -> u32;
}

impl CoffePriceImpl of PriceTrait{
    fn calculate_price(self: @CoffeeType, size: @CoffeeSize) -> u32{
        // match is similar to a switch statement
        let base_price: u32 = match self{
            CoffeeType::Americano => 30,
            CoffeeType::Cappucino => 25,
            CoffeeType::Espresso => 40,
            CoffeeType::Latte => 20
        };

        let size_price = match size{
            CoffeeSize::Small => 5,
            CoffeeSize::Medium => 7,
            CoffeeSize::Large => 9
        };

        base_price + size_price
    }
}

trait StockCheckTrait {
    fn in_stock(self: @CoffeeType, stock: @Stock) -> bool;
}

impl StockCheckImpl of StockCheckTrait{
    fn in_stock(self: @CoffeeType, stock: @Stock) -> bool{
        // * is used to get the real value
        let beans = *stock.coffee_beans;
        let milk = *stock.milk;

        match self{
            // Needs at least 25g of coffe beans
            CoffeeType::Americano => beans >= 25,
            // Needs at least 20g of coffee beans and 25ml of milk
            CoffeeType::Cappucino =>
        }
    }


}