
# Handling Consecutive Frames in CAPL

This tutorial will guide you through the process of handling consecutive frames in CAPL (CAN Access Programming Language). We'll go through each step, including variable declaration, message handling, and consecutive frame processing, using code snippets to illustrate each part.

## Prerequisites

- Basic understanding of CAPL programming.
- Familiarity with CAN protocol and UDS (Unified Diagnostic Services).

## Table of Contents

1. Variable Declaration
2. Handling Messages
3. Initiating Tester Present Message
4. Programming Session Control
5. Writing Data Identifier
6. Handling Consecutive Frames
7. Handling Positive and Negative Responses
8. Logging and Error Handling

### 1. Variable Declaration

We start by declaring the necessary variables. These will be used throughout the CAPL script.

```capl
variables {
  message testerPresent;
  message progSessionCtrl;
  message writeDataById;
  message frame[4]; // Array to handle consecutive frames
}
```

### 2. Handling Messages

Next, we define how incoming messages are handled. We set the DLC (Data Length Code) and initialize the message structure.

```capl
on message 0x1E0 {
  this.DLC = 8;
  // Further message initialization if needed
}

on message 0x1E8 {
  // Handle response message here
}
```

### 3. Initiating Tester Present Message

The Tester Present message needs to be sent cyclically to indicate that the tester is active.

```capl
on key 't' { // Start Tester Present
  setTimerCyclic("timerTesterPresent", 2000); // 2000ms interval
}

on timer "timerTesterPresent" {
  testerPresent.byte(0) = 0x02;
  testerPresent.byte(1) = 0x3E;
  testerPresent.byte(2) = 0x80;
  for (int i = 3; i < 8; i++) {
    testerPresent.byte(i) = 0x00;
  }
  output(testerPresent);
}
```

### 4. Programming Session Control

We define the programming session control which switches the ECU into a programming session.

```capl
on key 'p' { // Start Programming Session
  progSessionCtrl.byte(0) = 0x02;
  progSessionCtrl.byte(1) = 0x10;
  progSessionCtrl.byte(2) = 0x02; // Programming Session Sub-function
  for (int i = 3; i < 8; i++) {
    progSessionCtrl.byte(i) = 0x00;
  }
  output(progSessionCtrl);
}
```

### 5. Writing Data Identifier

We handle the writing of data identifiers, which may require sending multiple frames if the data exceeds 8 bytes.

```capl
on key 'w' { // Start Write Data by Identifier
  writeDataById.byte(0) = 0x10; // Indicates first frame
  writeDataById.byte(1) = 0x45; // Data Identifier (Example)
  writeDataById.byte(2) = 0x23;
  writeDataById.byte(3) = 0x00;
  writeDataById.byte(4) = 0x01;
  writeDataById.byte(5) = 0x02;
  writeDataById.byte(6) = 0x03;
  writeDataById.byte(7) = 0x04;
  output(writeDataById);
  
  // Initialize subsequent frames
  frame[0].byte(0) = 0x21; // First Consecutive Frame
  frame[0].byte(1) = 0x05;
  frame[0].byte(2) = 0x06;
  frame[0].byte(3) = 0x07;
  frame[0].byte(4) = 0x08;
  frame[0].byte(5) = 0x09;
  frame[0].byte(6) = 0x0A;
  frame[0].byte(7) = 0x0B;

  frame[1].byte(0) = 0x22; // Second Consecutive Frame
  frame[1].byte(1) = 0x0C;
  frame[1].byte(2) = 0x0D;
  frame[1].byte(3) = 0x0E;
  frame[1].byte(4) = 0x0F;
  frame[1].byte(5) = 0x10;
  frame[1].byte(6) = 0x11;
  frame[1].byte(7) = 0x12;
  
  // Set timer to send consecutive frames
  setTimer("timerConsecutiveFrame", 20); // 20ms delay for example
}
```

### 6. Handling Consecutive Frames

We use a timer to handle sending of consecutive frames.

```capl
on timer "timerConsecutiveFrame" {
  static int frameIndex = 0;
  if (frameIndex < 2) { // Adjust based on number of frames
    output(frame[frameIndex]);
    frameIndex++;
    setTimer("timerConsecutiveFrame", 20);
  } else {
    frameIndex = 0; // Reset for next use
  }
}
```

### 7. Handling Positive and Negative Responses

We need to handle the responses from the ECU to determine if the requests were successful.

```capl
on message 0x7E8 {
  if (this.byte(0) == 0x50 && this.byte(1) == 0x02) {
    writeToLog("Programming Session Control Successful");
  } else if (this.byte(0) == 0x7F) {
    switch (this.byte(2)) {
      case 0x12:
        writeToLog("Sub-function not supported");
        break;
      case 0x13:
        writeToLog("Incorrect message length or invalid format");
        break;
      default:
        writeToLog("Unknown Negative Response");
    }
  }
}
```

### 8. Logging and Error Handling

We implement logging for easier debugging and error tracking.

```capl
writeToLog("Starting Test Sequence");

on key 's' { // Stop Test Sequence
  cancelTimer("timerTesterPresent");
  cancelTimer("timerConsecutiveFrame");
  writeToLog("Stopped Test Sequence");
}

on start {
  writeToLog("CAPL script started");
}

on stop {
  writeToLog("CAPL script stopped");
}
```

### Conclusion

This tutorial provided a comprehensive overview of handling consecutive frames in CAPL. You should now be able to implement and debug consecutive frame handling in your CAPL scripts effectively. Ensure you test each part thoroughly and use logging to track and resolve issues.
