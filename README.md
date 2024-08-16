# Memory-Verification-using-UVM
### Overview
This project is focused on creating a class-based verification environment using SystemVerilog and UVM  environment to verify a Single Port Memory module. The project includes the design of a test bench, an interface, and the memory module itself. The primary goal is to ensure the memory module functions correctly by simulating various scenarios through a structured environment.



## Memory Block Diagram 
![memory block](./memory_block.jpg)
This diagram represents the Single Port Memory module. It shows the inputs and outputs of the memory, including:
- **clk**: clock signal.
- **reset_n**: active-low reset signal.
- **write_en**: write enable signal.
- **read_en**: read enable signal.
- **data_in [32]**: 32-bit input data bus.
- **address [4]**: 4-bit address bus.
- **data_out [32]**: 32-bit output data bus.
- **valid_out**: output valid signal indicating data availability.


## Class based Env Diagram
![Class Environment](./env_diagram.jpg)
This diagram illustrates the architecture of the test bench environment. It includes the following components:

- **Interface**: Encapsulates all input and output signals for the DUT except the clk signal.
- **Virtual Interface**: Acts as an abstraction layer between the test bench components and the memory DUT.
- **Transaction Class**: Encapsulates the data that is transferred between different components.
- **Sequencer Class**: Responsible for generating and managing the sequence of transactions.
- **Driver Class**: Drives the transactions to the DUT (Design Under Test) using the virtual interface.
- **Monitor Class**: Monitors signals and captures the transactions for analysis and send them to Scoreboard and Subscriber.
- **Subscriber Class**: Receives transactions from the Monitor and processes them to collect coverage.
- **Scoreboard Class**: Compares expected and actual results to determine if the DUT behaves as intended.

## General Workflow inside Class Based Environment

1. **Initialization**: The test bench environment is initialized inside top module, setting up all classes, interfaces, and their connections.

2. **Transaction Generation**: The Sequencer generates a sequence of transactions using randomization to test various scenarios such as reads, writes, resets, addresses and data input.

3. **Transaction Execution**: The Driver takes these transactions and map them on the DUT through the Virtual Interface.

4. **Monitoring**: The Monitor observes the execution and sends the captured transactions to the Subscriber and Scoreboard.

5. **Analysis**: The Subscriber processes the transactions and collects coverage.

6. **Validation**: The Scoreboard checks if the actual output matches the expected output, determining if the DUT passes the test.

## Class based Env Diagram
to be completed
