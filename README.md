# subscribe_coding_challenge

This is a solution for the [coding challenge](challenge.md) issued by +SUBSCRIBE.

## Prerequisites

You must have either [Ruby](https://www.ruby-lang.org/en/) or [Docker](https://www.docker.com/) installed.

## How to Run

Add files containing the input orders to the `orders` folder on the project.

### Using Ruby
```ruby
ruby app.rb
```

### Using Docker

There are a few scripts which can speed the process of setting the image up and either running the application itself or the test suite.

Run the following command to build the image:
```bash
script/setup
```

You can then run the app using the following script:
```bash
script/run
```

## How to Test

### Using Ruby

Make sure you have installed the needed dependencies:
```bash
bundle install
```

You can then run the test suite using:
```bash
rspec
```

### Using Docker

Run the following command to build the image:
```bash
script/setup
```

You can then run the test suite using the following script:
```bash
script/test
```

## Assumptions made
- One or more files will be supplied with the items to be processed for each order
- All items must follow the following structure:
  1) Quantity
  2) The keyword `imported` when the item is imported
  3) Item description
  4) The item description and its price must be separated by the keyword `at`
  5) The item price must be either an Integer or a Float number (in which case there must be a `.` decimal separator)
