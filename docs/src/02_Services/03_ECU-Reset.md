# ECU-Reset (0x11)

## Einführung

Die Unified Diagnostic Services (UDS) stellen ein standardisiertes Kommunikationsprotokoll zur Verfügung, das in der Fahrzeugdiagnose verwendet wird, um mit den elektronischen Steuergeräten (ECUs) zu kommunizieren. Der ECU-Reset-Dienst (Service ID 0x11) ermöglicht es, das Steuergerät neu zu starten.

### Zweck des ECU-Reset-Dienstes

Der ECU-Reset-Dienst wird verwendet, um das Steuergerät neu zu starten. Dies kann aus verschiedenen Gründen notwendig sein, wie z.B. nach einer Fehlerbehebung oder zur Vorbereitung auf eine Firmware-Aktualisierung.

### Funktionsweise

1. **Positive Rückmeldung vor dem Neustart**: Die ECU sendet eine positive Rückmeldung an den Tester, bevor der Neustart durchgeführt wird. Nach einem erfolgreichen Neustart aktiviert die ECU die Standard-Sitzung.
2. **Keine Annahme anderer Anfragen während des Neustarts**: Während der Neustart läuft, akzeptiert die ECU keine anderen Anfragen und sendet keine Antwortnachrichten.
3. **Keine Datenparameter im Anforderungsrahmen**: Der ECU-Reset-Dienst unterstützt keine Datenparameter in der Anforderungsnachricht.

## Unterfunktionen

Die Unterfunktionen des ECU-Reset-Dienstes spezifizieren verschiedene Arten von Resets. Diese sind in den folgenden Wertebereichen definiert:

- **0x00**: SAE Reserviert
- **0x01**: Hard Reset
- **0x02**: Key Off On Reset
- **0x03**: Soft Reset
- **0x04**: Enable Rapid Power Shut Down
- **0x05**: Disable Rapid Power Shut Down
- **0x06 bis 0x3F**: ISO SAE Reserviert
- **0x40 bis 0x5F**: OEM-spezifisch
- **0x60 bis 0x7E**: Lieferantenspezifisch
- **0x7F**: SAE Reserviert

### Beschreibung der Unterfunktionen

1. **Hard Reset (0x01)**:
   - Macht die ECU durch eine physische Bedingung, die den Stromausfall oder das Starten nach der Trennung der Stromversorgung simuliert, zurücksetzen. Dabei werden flüchtige und nicht-flüchtige Speicher sowie andere elektronische Komponenten initialisiert, ähnlich wie beim Hochfahren.

2. **Key Off On Reset (0x02)**:
   - Simuliert das Ausschalten und erneute Einschalten des Zündschlüssels. Diese Aktion unterbricht die Stromversorgung und wird in der Regel so implementiert, dass flüchtige Speicher initialisiert werden, während nicht-flüchtige Speicher erhalten bleiben.

3. **Soft Reset (0x03)**:
   - Verursacht einen sofortigen Neustart der Anwendung. Diese Aktion wird durch Software durchgeführt und erfordert keine physische Intervention. Typischerweise wird die Anwendung neu gestartet, ohne zuvor gelernte Konfigurationsdaten, adaptive Faktoren oder andere langfristige Anpassungen zu reinitialisieren.

4. **Enable Rapid Power Shut Down (0x04)**:
   - Fordert die ECU auf, eine schnelle Abschaltung der Stromversorgung durchzuführen, die sofort nach dem Ausschalten der Zündung erfolgt. Während dieser Zeit dürfen keine Anfragen an die ECU gesendet werden, um den Prozess nicht zu stören.

5. **Disable Rapid Power Shut Down (0x05)**:
   - Hebt die zuvor aktivierte Funktion der schnellen Abschaltung auf.

## Anforderungs- und Rückmeldungsrahmen

### Anforderungsrahmen

1. Service-ID
2. Unterfunktion (Reset)

### Positive Rückmeldungsrahmen

1. Service-ID
2. Unterfunktion (Reset)

### Negative Rückmeldungsrahmen

1. Negative Rückmeldung (7F)
2. Service-ID
3. Fehlercode (NRC)

## Fehlercodes (Negative Response Codes - NRCs)

Die folgenden NRCs können von der ECU zurückgesendet werden:

- **0x12**: Unterfunktion nicht unterstützt
- **0x13**: Falsche Nachrichtenlänge
- **0x22**: Bedingungen nicht erfüllt
- **0x33**: Sicherheitszugriff verweigert

### Beschreibung der NRCs

1. **Unterfunktion nicht unterstützt (0x12)**:
   - Diese Rückmeldung wird gesendet, wenn der Tester eine nicht unterstützte Unterfunktion anfordert.

2. **Falsche Nachrichtenlänge (0x13)**:
   - Diese Rückmeldung wird gesendet, wenn die Länge der Anforderungsnachricht nicht korrekt ist.

3. **Bedingungen nicht erfüllt (0x22)**:
   - Diese Rückmeldung wird gesendet, wenn die Bedingungen für die Ausführung des Dienstes nicht erfüllt sind, z.B. wenn der Motor noch läuft, obwohl er ausgeschaltet sein sollte.

4. **Sicherheitszugriff verweigert (0x33)**:
   - Diese Rückmeldung wird gesendet, wenn der Dienst ohne Freigabe des Sicherheitszugriffs angefordert wird.

## Schlussfolgerung

Die Dokumentation des ECU-Reset-Dienstes (0x11) zeigt die verschiedenen Arten von Resets, die ausgeführt werden können, sowie die Bedingungen und Fehlercodes, die bei der Kommunikation zwischen Tester und ECU auftreten können. Diese Informationen sind essentiell für die korrekte Implementierung und Diagnose im Automobilbereich.
