# Write Memory By Address (0x3D)

**Introduction:**
Welcome to the fifth part of our Unified Diagnostic Services (UDS) tutorial series. In this tutorial, we will focus on the Write Memory By Address service (0x3D), a crucial aspect of UDS used in automotive embedded systems. This service allows the client to write data into the Electronic Control Unit (ECU) at specific memory locations. We'll delve into the description of the service, its request and response frames, along with code snippets to illustrate its implementation.

---

**Description of Service ID 0x3D:**
The Write Memory By Address service (0x3D) facilitates writing data into one or more shared memory locations within the ECU. Unlike the Write Data By Identifier service, which uses identifiers to write data, this service writes data directly into memory locations specified by addresses. Key aspects of this service include:

1. **Purpose**: The primary purpose of this service is twofold:
   - Clearing non-volatile memory (NVM): Used for resetting or erasing stored data, including diagnostic trouble codes (DTCs) or calibration values.
   - Changing calibration values: Allows modification of reference values stored in memory.

2. **Data Format**: The service request can consist of 2, 3, or 4 bytes of data (16, 24, or 32 bits), depending on the size of the memory address and data to be written.

3. **No Sub-functions**: Unlike some other UDS services, Write Memory By Address (0x3D) does not support any sub-functions.

---

**Request and Response Frames:**
The request and response frames for the Write Memory By Address service are structured as follows:

1. **Request Frame**:
   - Service ID: 0x3D
   - Data Length: Variable, depending on the size of memory address and data to be written.
   - Data Fields:
     - Address: Specifies the memory location where data will be written.
     - Length: Indicates the length of the data to be written.
     - Format Identifier: Defines the format of the data.
     - Memory Size: Specifies the size of the memory to be written.
     - Data: The actual data to be written into memory.

2. **Response Frame**:
   - Positive Response:
     - Format: 40 + Service ID (0x3D)
     - Data Fields:
       - Status: Indicates whether the operation was successful.
   - Negative Response:
     - Format: 0x7F + Service ID (0x3D) + Error Code
     - Error Code: Specifies the type of error encountered during the operation.

---

**Code Implementation:**
Below are code snippets demonstrating the implementation of the Write Memory By Address service in a hypothetical automotive embedded system:

```python
# Python Implementation of Write Memory By Address Service

def write_memory_by_address(address, data):
    # Construct request frame
    request_frame = [0x3D]  # Service ID
    request_frame.extend([address >> 8, address & 0xFF])  # Memory Address (2 bytes)
    request_frame.extend([len(data)])  # Data Length
    request_frame.extend(data)  # Data to be written
    
    # Send request frame to ECU
    send_request_to_ecu(request_frame)

def handle_positive_response(response):
    status = response[1]
    if status == 0x00:
        print("Write operation successful.")
    else:
        print("Write operation failed.")

def handle_negative_response(response):
    error_code = response[2]
    print(f"Write operation failed. Error Code: {error_code}")

# Example Usage
address = 0x0010  # Memory Address
data_to_write = [0xAA, 0xBB, 0xCC, 0xDD]  # Data to be written
write_memory_by_address(address, data_to_write)
```
