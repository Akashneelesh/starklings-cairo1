// enums2.cairo
// Execute `starklings hint enums2` or use the `hint` watch subcommand for a hint.


use debug::PrintTrait;
use array::ArrayTrait;
use traits::Into;

#[derive(Copy, Drop)]
enum Message { // TODO: define the different variants used below
Quit:(), Echo:(felt252), Move:(u32,u32), ChangeColor:(u8,u8,u8)
}


fn main() {
    let mut messages: Array<Message> = ArrayTrait::new();
    messages.append(Message::Quit(()));
    messages.append(Message::Echo('hello world'));
    messages.append(Message::Move((10_u32, 30_u32)));
    messages.append(Message::ChangeColor((0_u8, 255_u8, 255_u8)));

    print_messages_recursive(messages, 0_u32)
}

// Utility function to print messages. Don't modify these.

trait MessageTrait<T> {
    fn call(self: T);
}

impl MessageImpl of MessageTrait::<Message> {
    fn call(self: Message) {
        self.print()
    }
}

fn print_messages_recursive(messages: Array<Message>, index: u32) {
    match gas::withdraw_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = ArrayTrait::<felt252>::new();
            data.append('OOG');
            panic(data);
        },
    }
    if index >= messages.len() {
        return ();
    }
    let message = *messages.at(index);
    message.call();
    print_messages_recursive(messages, index + 1_u32)
}


impl MessagePrintImpl of PrintTrait::<Message> {
    fn print(self: Message) {
        ('___MESSAGE BEGINS___').print();
        match self {
            Message::Quit(()) => ('Quit').print(),
            Message::Echo(msg) => msg.print(),
            Message::Move((a, b)) => {
                a.print();
                b.print();
            },
            Message::ChangeColor((
                red, green, blue
            )) => {
                red.print();
                green.print();
                blue.print();
            }
        }
        ('___MESSAGE ENDS___').print();
    }
}
