# UDS Reset ECU (0x11)

**Purpose:**
The Reset ECU service (0x11) in the Unified Diagnostic Services (UDS) protocol is utilized to restart the Electronic Control Unit (ECU) within a vehicle or any other applicable system. This service provides a means to initiate a reset operation on the targeted ECU, allowing for various forms of restart procedures.

**Introduction:**
Before executing the reset operation on the ECU, the ECU sends a positive response to the tester to acknowledge the request. Upon successful execution of the reset, the server activates the default session. It's important to note that during the reset procedure, the ECU will not accept any other request messages nor send any response messages.

**Sub-functions:**
The Reset ECU service supports various sub-functions to enable different types of reset operations. These sub-functions are enumerated below:

| Enum Values | Description                    |
|-------------|--------------------------------|
| 0x00        | SAE Reserved                   |
| 0x01        | Hard Reset                     |
| 0x02        | Key Off On Reset               |
| 0x03        | Soft Reset                     |
| 0x04        | Enable Rapid Power Shut Down   |
| 0x05        | Disable Rapid Power Shut Down  |
| 0x06 to 0x3F| ISO SAE Reserved               |
| 0x40 to 0x5F| OEM Specific                   |
| 0x60 to 0x7E| Supplier Specific              |
| 0x7F        | SAE Reserved                   |

**Request Frame:**
The request frame for the Reset ECU service consists of the following:

1. Service Identifier (0x11)
2. Sub-function (Reset)

**Positive Response Frame:**
Upon successful execution of the reset operation, the positive response frame contains:

1. Service Identifier (0x11)
2. Sub-function (Reset)

**Negative Response Frame:**
In case of failure or error during the reset procedure, the negative response frame includes:

1. Negative Response Identifier (0x7F)
2. Service Identifier (0x11)
3. Negative Response Code (NRC)

**Assumption Scenario:**
In a typical scenario, a tester utilizes the Reset ECU service to initiate a reset on the ECU for various reasons. These reasons can vary and are not limited to any specific conditions. For example, the tester might initiate a reset to resolve software issues, clear error codes, or perform maintenance tasks.

**Notes:**
- The reset operation might have implications on the functionality of the ECU and should be performed with caution.
- It's crucial to adhere to manufacturer guidelines and specifications when utilizing the Reset ECU service.
- The availability and behavior of sub-functions may vary depending on the implementation and the specific ECU being targeted.
- Proper error handling mechanisms should be in place to deal with negative responses and unexpected behavior during the reset procedure.
- The Reset ECU service does not support data parameters in the request message, indicating that the reset operation is generally a command without additional data payload.


**1. Hard Reset (0x01):**
The Hard Reset sub-function initiates a reset on the ECU by simulating the power-on or start-up condition. This reset is akin to the ECU being disconnected from its power supply (e.g., battery) and then reconnected. Upon execution, both volatile and non-volatile memory within the ECU, along with other electronic sub-components, are initialized as part of the power-up sequence.

**2. Key Off On (0x02):**
This sub-function replicates the action of the vehicle driver turning the ignition key off and then back on. It simulates a key-off-on sequence by interrupting the power supply to the ECU. The exact action performed during this reset condition can vary based on implementation requirements and is not strictly defined by standards. Typically, values stored in non-volatile memory locations are preserved, while volatile memory is initialized.

**3. Soft Reset (0x03):**
The Soft Reset sub-function triggers an immediate restart of the application running on the server. Unlike hard resets, soft resets are performed through software rather than physical means. Implementation specifics for this reset are not standardized and can vary. Typically, a soft reset involves restarting the application without re-initializing previously learned configuration data, adaptive factors, and other long-term adjustments.

**4. Enable Rapid Power Shutdown (0x04):**
Enabling Rapid Power Shutdown requests the server to activate and execute a rapid power shutdown function. This function is executed immediately after the key/ignition is switched off. During the execution of the power down function, the server transitions, either directly or after a defined standby time, to sleep mode. It's essential for the client not to send any request messages during this time to avoid disrupting the rapid power shutdown function. Note that this sub-function is only applicable to servers supporting a standby mode.

**5. Disable Rapid Power Shutdown (0x05):**
The Disable Rapid Power Shutdown sub-function requests the server to deactivate the previously enabled "rapid power shutdown" function. This is done to disable the rapid power shutdown functionality, which might have been enabled using the Enable Rapid Power Shutdown sub-function.

These sub-functions provide a range of options for resetting the ECU, each tailored to specific requirements and conditions. The choice of sub-function depends on the desired outcome of the reset operation and the capabilities of the server and ECU involved.