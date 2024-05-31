# Communication Control (Service ID 28)

## Introduction

In this guide, we will explore the "Communication Control" service, designated by Service ID 28. Despite its limited use in many automotive projects, it serves a critical function in managing communication between Electronic Control Units (ECUs) within a vehicle network. Understanding this service is essential for developing robust automotive communication systems.

## Objective of Communication Control

The primary objective of the Communication Control service is to regulate the communication between ECUs and other networks. This regulation can occur in four distinct ways:

1. **Disabling Communication**: Both ECUs stop communicating.
2. **Enable Transmission Only**: Only the transmission is permitted while reception is disabled.
3. **Enable Reception Only**: Only the reception is permitted while transmission is disabled.
4. **Enable Both Transmission and Reception**: Both ECUs can freely transmit and receive messages.

These methods constitute the sub-functions of the Communication Control service, allowing fine-grained control over ECU communications.

## Sub-Functions of Communication Control

The service manages communication between two ECUs, which we will refer to as ECU A and ECU B. The sub-functions include:

1. **Enable Both (0x00)**: Enables both transmission and reception.
2. **Enable Transmission Only (0x01)**: Enables transmission only.
3. **Enable Reception Only (0x02)**: Enables reception only.
4. **Disable Both (0x03)**: Disables both transmission and reception.

### Enhanced Address Information

The service also supports enhanced sub-functions that allow more targeted control:

1. **Enable Both with Enhanced Address Information (0x04)**: Enables both transmission and reception for a specific node.
2. **Enable Transmission Only with Enhanced Address Information (0x05)**: Enables transmission for a specific node.
3. **Enable Reception Only with Enhanced Address Information (0x06)**: Enables reception for a specific node.
4. **Disable Both with Enhanced Address Information (0x07)**: Disables both transmission and reception for a specific node.

## Types of Communication

Communication can be categorized into two types:

1. **Normal Communication**: Communication within the same network (e.g., between different ECUs within a single vehicle).
2. **Network Communication**: Communication between different networks (e.g., between vehicles or between a vehicle and external infrastructure).

### Scenario Example

Consider a vehicle equipped with adaptive cruise control. The system communicates with another vehicle to maintain a safe following distance. This communication could be classified as normal (within the vehicle's network) or network (between different vehicles). The Communication Control service ensures that messages are transmitted or received according to the specified sub-function.

## Communication Control Frame Structure

### Request Frame

The request frame for this service includes the following components:

1. **Service ID (0x28)**: Identifies the Communication Control service.
2. **Sub-function**: Specifies the desired control action (e.g., 0x00 for enabling both).
3. **Communication Type**: Indicates whether the communication is normal or network type.
4. **Node Identification Number (optional)**: Specifies the node to which the control applies.

### Positive Response

The positive response frame confirms that the requested action has been successfully applied. It mirrors the request with a positive response indicator (e.g., 0x60).

### Negative Response

Negative responses indicate errors or unsupported actions. Common error codes include:

- **0x12**: Sub-function not supported.
- **0x13**: Incorrect message length.
- **0x22**: Conditions not correct.
- **0x31**: Request out of range.

## Implementation Examples

### Enabling Both Transmission and Reception (0x00)

**Request Frame**:

```
28 00 01
```

**Positive Response Frame**:

```
60 00
```

### Enabling Transmission Only (0x01)

**Request Frame**:

```
28 01 01
```

**Positive Response Frame**:

```
60 01
```

### Enabling Reception Only (0x02)

**Request Frame**:

```
28 02 01
```

**Positive Response Frame**:

```
60 02
```

### Disabling Both (0x03)

**Request Frame**:

```
28 03 01
```

**Positive Response Frame**:

```
60 03
```

### Enhanced Address Information Examples

For enhanced control using node identification numbers, the frame structure extends to include the specific node:

**Request Frame for Enabling Both with Enhanced Address Information**:

```
28 04 01 01 02
```

**Positive Response Frame**:

```
60 04
```

## Log Analysis

Logs are crucial for debugging and validating the functionality of the Communication Control service. Logs typically capture request and response frames, allowing analysis of whether the requested action was successfully applied.

### Example Log Entry

For enabling both transmission and reception:

**Request**:

```
28 00 01
```

**Response**:

```
60 00
```

Logs can be examined using text editors or specialized log analysis tools to verify the correctness of the communication control actions.

## Conclusion

The Communication Control service (Service ID 28) is an essential tool for managing ECU communications within a vehicle network. By understanding and utilizing its sub-functions, engineers can effectively control and debug communication scenarios. This guide has provided a detailed overview of the service's purpose, sub-functions, communication types, frame structures, and practical implementation steps, offering a comprehensive understanding of how to leverage this service in automotive applications.
