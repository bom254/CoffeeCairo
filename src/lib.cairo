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