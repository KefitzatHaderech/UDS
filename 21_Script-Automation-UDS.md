# Script Automation - UDS

This tutorial aims to provide an in-depth explanation of consecutive frames and how to handle them in automotive diagnostics communication protocols. We'll explore the concept, variable declarations, frame handling, and related functionalities using code examples.

## Variables and Declarations

Before diving into the core functionality, let's declare the necessary variables:

```c
// Include section for necessary libraries

// Variable declarations
int testPresent; // Variable for tester present
int progSessionControl; // Variable for programming session control
int writeDID; // Variable for writing data identifier

// Consecutive frames declaration
int consecutiveFrames; // Variable to handle consecutive frames
```

Here, we declare variables for tester present, programming session control, and writing data identifier (writeDID). Additionally, we declare a variable `consecutiveFrames` to handle consecutive frames.

## Tester Present Request

The `onMessage` block is used to handle incoming messages. In this case, we define the tester present request:

```c
// onMessage block
onMessage(0x1E0) {
    msg.dlc = 0x08; // Setting the data length code to 8 bytes
    msg.data[0] = 0x02; // Tester present service ID length
    msg.data[1] = 0x3E; // Tester present service ID
    msg.data[2] = 0x80; // Subfunctional request
    // Fill the remaining bytes with 0x00
    for (int i = 3; i < 8; i++) {
        msg.data[i] = 0x00;
    }
}
```

Here, we set the data length code (DLC) to 8 bytes, followed by the tester present service ID (0x02, 0x3E), and a subfunctional request (0x80). The remaining bytes are filled with 0x00.

## Programming Session Control

Next, we define the programming session control request:

```c
// onMessage block
onMessage(0x1E0) {
    msg.dlc = 0x02; // Setting the data length code to 2 bytes
    msg.data[0] = 0x10; // Programming session control service ID length
    msg.data[1] = 0x02; // Programming session control service ID
}
```

In this case, we set the DLC to 2 bytes, followed by the programming session control service ID (0x10, 0x02).

## Writing Data Identifier (writeDID)

To write the data identifier (writeDID), we need to handle consecutive frames if the data exceeds 8 bytes:

```c
// Variable declarations
int frame1, frame2, frame3, frame4; // Variables for individual frames

// onMessage block
onMessage(0x1E0) {
    msg.dlc = 0x0A; // Setting the data length code to 10 bytes
    msg.data[0] = 0x2E; // Write data by identifier service ID length
    msg.data[1] = 0x10; // Write data by identifier service ID
    msg.data[2] = 0x45; // Data identifier (DID)

    // Initialize frame variables
    frame1 = 0x2101040506070809; // First frame
    frame2 = 0x220A0B0C0D0E0F10; // Second frame
    frame3 = 0x2311121314151617; // Third frame
    frame4 = 0x2418191A1B1C1D1E; // Fourth frame

    // Call consecutive frames block
    consecutiveFrames();
}
```

Here, we declare variables for individual frames (`frame1`, `frame2`, `frame3`, `frame4`). In the `onMessage` block, we set the DLC to 10 bytes and define the write data by identifier service ID (0x2E, 0x10) along with the data identifier (DID) (0x45). We then initialize the frame variables with the data to be sent in consecutive frames.

Finally, we call the `consecutiveFrames()` function to handle the consecutive frame transmission.

## Consecutive Frames Handling

The `consecutiveFrames()` function is responsible for sending the frames in the correct order:

```c
consecutiveFrames() {
    inFrame1();
    inFrame2();
    inFrame3();
    inFrame4();
}

inFrame1() {
    msg.data[3] = (frame1 >> 24) & 0xFF; // Extract the first byte of frame1
    msg.data[4] = (frame1 >> 16) & 0xFF; // Extract the second byte of frame1
    // ... and so on for the remaining bytes
    transmitFrame(); // Transmit the frame
}

// Similar functions for inFrame2(), inFrame3(), and inFrame4()
```

Inside the `consecutiveFrames()` function, we call the individual frame functions (`inFrame1()`, `inFrame2()`, `inFrame3()`, and `inFrame4()`) to transmit each frame. For example, in the `inFrame1()` function, we extract the individual bytes from the `frame1` variable and populate the `msg.data` array accordingly. Finally, we call the `transmitFrame()` function to transmit the frame over the communication protocol.

## Response Handling

After sending the requests, we need to handle the responses received from the ECU:

```c
// onMessage block for response handling
onMessage(0x7E8) {
    if (msg.data[0] == 0x50 && msg.data[1] == 0x02) {
        print("Positive response for programming session control");
    } else if (msg.data[0] == 0x7F && msg.data[1] == 0x10 && msg.data[2] == 0x12) {
        print("Subfunction not supported NRC");
    } else if (msg.data[0] == 0x7F && msg.data[1] == 0x10 && msg.data[2] == 0x13) {
        print("Incorrect message length or invalid format");
    } else if (msg.data[0] == 0x30 && msg.data[1] == 0x00) {
        print("Positive response received for multi-frame message");
    } else if (msg.data[0] == 0x6E && msg.data[1] == 0x00) {
        print("Data written successfully");
    } else if (msg.data[0] != 0x6E) {
        print("Data not written successfully");
    }
}
```

In the `onMessage` block for response handling, we check the received message data against various conditions to determine the response type. For example, if the first byte is 0x50 and the second byte is 0x02, we print "Positive response for programming session control". Similarly, we handle different response codes, such as subfunction not supported NRC, incorrect message length or invalid format, positive response for multi-frame messages, data written successfully, and data not written successfully.

## Timer and Cleanup

To ensure proper execution and cleanup, we can use timers and cancel timers:

```c
// Set timers
onKey('T') {
    setTimer(cyclic, 2000); // Set a cyclic timer for tester present every 2 seconds
}

onKey('P') {
    setTimer(programSessionControl); // Set a timer for programming session control
}

onKey('W') {
    setTimer(writeDID); // Set a timer for writing data identifier
}

// Cancel timers
onStop() {
    cancelTimer(programSessionControl); // Cancel the programming session control timer
    cancelTimer(writeDID); // Cancel the write data identifier timer
    cancelTimer(testPresent); // Cancel the tester present timer
}
```

Here, we define `onKey` functions to set timers for tester present (`'T'`), programming session control (`'P'`), and writing data identifier (`'W'`). The `setTimer(cyclic, 2000)` function sets a cyclic timer for tester present every 2 seconds.

In the `onStop` function, we cancel the timers for programming session control, writing data identifier, and tester present using the `cancelTimer` function.

This tutorial covers the basics of consecutive frames, variable declarations, request and response handling, and timer management. By following the code snippets and explanations provided, you can gain a better understanding of how to handle consecutive frames in automotive diagnostics communication protocols.
