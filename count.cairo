#[starknet::interface]
trait ISimpleCounter<TContractState> {
    fn get_current_count(self: @TContractState) -> u256;
    fn increment(ref self: TContractState);
    fn decrement(ref self: TContractState);
}

#[starknet::contract]
mod SimpleCounter {
    #[storage]
    struct Storage {
        // Counter var
        counter: u256,
    }

    #[generate_trait]
    #[external(v0)]
    impl SimpleCounter of ISimpleCounter {
        fn get_current_count(self: @ContractState) -> u256 {
            return self.counter.read();
        }

        fn increment(ref self: ContractState) {
            // increase + 1
            let mut counter: u256 = self.counter.read() + 1;
            self.counter.write(counter);
        }
        fn decrement(ref self: ContractState) {
            // decrease - 1
            let mut counter: u256 = self.counter.read() - 1;
            self.counter.write(counter);
        }
    }
}
