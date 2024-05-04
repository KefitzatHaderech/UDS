# ECU Reset (0x11)

## Introduction to ECU Reset Service (0x11)

- The ECU Reset service is a fundamental aspect of vehicle diagnostics, enabling control units to be reset in various scenarios, such as after maintenance or troubleshooting procedures.
- It provides a standardized method for initiating a reset, ensuring compatibility across different vehicle manufacturers and models.

## Types of ECU Resets

There are several types of ECU resets supported within the UDS framework. These include:

1. **Hard Reset**: Initiates a complete reset of the ECU, similar to a power cycle.
2. **Key Off/On Reset**: Simulates turning the ignition key off and then on again.
3. **Soft Reset**: Allows for a controlled reset without power cycling the ECU.
4. **Enable Rapid Power Shutdown**: Enables rapid shutdown of power to the ECU after a specified time.
5. **Disable Rapid Power Shutdown**: Disables rapid power shutdown functionality.

Each reset type serves a specific purpose and may be used depending on the requirements of the diagnostic procedure.

## Implementing ECU Resets in UDS

### Hard Reset (Subfunction 0x01)

```c
// Sending Hard Reset request
CAN_message_t msg;
msg.id = 0x7DF; // Tester ID
msg.len = 3;    // Data length
msg.data[0] = 0x03; // UDS Length
msg.data[1] = 0x11; // Service ID
msg.data[2] = 0x01; // Subfunction: Hard Reset
CAN_send_message(msg);
```

### Key Off/On Reset (Subfunction 0x02)

```c
// Sending Key Off/On Reset request
CAN_message_t msg;
msg.id = 0x7DF; // Tester ID
msg.len = 3;    // Data length
msg.data[0] = 0x03; // UDS Length
msg.data[1] = 0x11; // Service ID
msg.data[2] = 0x02; // Subfunction: Key Off/On Reset
CAN_send_message(msg);
```

### Soft Reset (Subfunction 0x03)

```c
// Sending Soft Reset request
CAN_message_t msg;
msg.id = 0x7DF; // Tester ID
msg.len = 3;    // Data length
msg.data[0] = 0x03; // UDS Length
msg.data[1] = 0x11; // Service ID
msg.data[2] = 0x03; // Subfunction: Soft Reset
CAN_send_message(msg);
```

### Enable Rapid Power Shutdown (Subfunction 0x04)

```c
// Sending Enable Rapid Power Shutdown request
CAN_message_t msg;
msg.id = 0x7DF; // Tester ID
msg.len = 3;    // Data length
msg.data[0] = 0x03; // UDS Length
msg.data[1] = 0x11; // Service ID
msg.data[2] = 0x04; // Subfunction: Enable Rapid Power Shutdown
CAN_send_message(msg);
```

### Disable Rapid Power Shutdown (Subfunction 0x05)

```c
// Sending Disable Rapid Power Shutdown request
CAN_message_t msg;
msg.id = 0x7DF; // Tester ID
msg.len = 3;    // Data length
msg.data[0] = 0x03; // UDS Length
msg.data[1] = 0x11; // Service ID
msg.data[2] = 0x05; // Subfunction: Disable Rapid Power Shutdown
CAN_send_message(msg);
```
