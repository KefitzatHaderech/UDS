# Control DTC Setting

**Introduction**

The Control DTC Setting (0x85) service plays a pivotal role in the diagnostic ecosystem, offering testers the capability to manage Diagnostic Trouble Codes (DTCs) status bits within an Electronic Control Unit (ECU). By wielding this service, testers gain the power to suspend or resume the updating of DTC status bits, thus exerting precise control over diagnostic procedures. Mastery of this service is indispensable for optimizing diagnostics and maintenance workflows.

**Purpose**

The primary objective of the Control DTC Setting service is to empower testers with the ability to halt or recommence the setting of DTC status bits within the ECU. This control over the update process ensures that diagnostic operations unfold with precision, enhancing the accuracy of fault detection mechanisms.

**Sub-functions**

The Control DTC Setting service encompasses two distinct sub-functions:

1. **On (0x01):** This sub-function commands the ECU to resume updating trouble code status bits in the server's memory.
2. **Off (0x02):** Conversely, this sub-function directs the ECU to cease updating trouble code status bits in the server's memory.

**Request Frame**

When initiating a request to control DTC setting, the following frame structure is adhered to:

1. **Service Id:** This field delineates the service identifier (0x85).
2. **Sub-function:** Signifying the type of DTC setting operation to be executed (Resume or Stop).
3. **DTC Setting Control Option Record:** This optional data payload allows the tester to specify particular DTCs to be toggled on or off.

**Positive Response Frame**

Upon successful execution of the request, the ECU dispatches a positive response comprising:

1. **Service Id:** Identifying the service (0x85).
2. **Sub-function:** Validating the type of DTC setting operation executed (Resume or Stop).
3. **DTC Setting Control Option Record:** Furnishing optional intelligence regarding the controlled DTCs.

**Negative Response Frame**

Should the requested operation be unfeasible, the ECU issues a negative response, inclusive of:

1. **Negative Response (7F):** Indicating a negative response.
2. **Service Id:** Specifying the service (0x85).
3. **NRC Code:** Detailing the rationale behind the rejection or failure.

**Circumstances for Resume Operation**

The resumption of setting trouble codes into the server's memory may occur under the following circumstances:

1. **Sub-function (DTC Setting Type: Resume):** Triggered when the tester solicits a resume operation.
2. **ECU Reset:** Following an ECU reset, the setting of trouble codes may automatically resume as part of the initialization process.
3. **Session Transition:** In scenarios where the session transition does not accommodate service (0x85), the ECU may autonomously resume DTC setting.
4. **Clear DTC Information:** The act of clearing DTC information might serve as a catalyst for the resumption of trouble code setting, especially if previously suspended.