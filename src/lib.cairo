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
    fn needed_ingredients(self: @CoffeeType);
}

impl StockCheckImpl of StockCheckTrait{
    fn in_stock(self: @CoffeeType, stock: @Stock) -> bool{
        // * is used to get the real value
        let beans = *stock.coffee_beans;
        let milk = *stock.milk;

        match self{
            // Needs at least 25g of coffee beans
            CoffeeType::Americano => beans >= 25,
            // Needs at least 20g of coffee beans and 25ml of milk
            CoffeeType::Cappucino => beans >= 20 && milk >=25,
            // Needs at least 20g of coffee beans and 50ml of milk
            CoffeeType::Espresso => beans >= 20 && milk >= 50,
            // Needs at least 20g of coffee beans and 100ml of milk
            CoffeeType::Latte => beans >= 20 && milk >=100
        }
    }

    fn needed_ingredients(self: @CoffeeType){
        match self{
            CoffeeType::Americano => println!("For Americano we need: 25g of coffee beans."),
            CoffeeType::Cappucino => println!("For Americano we need: 20g of coffee beans and 25ml of milk."),
            CoffeeType::Espresso => println!("For Americano we need: 20g of coffee beans and 50ml of milk."),
            CoffeeType::Latte => println!("For Americano we need: 20g of coffee beans and 100ml of milk.")
        }
    }
}

#[derive(Drop)]
struct Order{
    coffee_type: CoffeeType,
    size: CoffeeSize
}

fn process_order(order: Order, stock: @Stock){
    let coffee = @order.coffee_type;

    if StockCheckTrait::in_stock(coffee, stock){
        let price = PriceTrait::calculate_price(coffee, @order.size);
        println!("Your coffee is available Total price is: {price}");
    } else{
        println!("We are sorry, we don't have enough ingredients for this coffee right now");
        StockCheckTrait::needed_ingredients(coffee);
    }
}

fn main() {
    let shop_stock = Stock{milk:200, coffee_beans: 400};

    let customer1_order = Order{coffee_type: CoffeeType::Espresso, size:CoffeeSize::Small};
    println!("Processing your order");
    process_order(customer1_order, @shop_stock);
}