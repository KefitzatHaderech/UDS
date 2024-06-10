# Diagnosesitzungssteuerung (0x10)

## Einleitung

Die Unified Diagnostic Services (UDS) sind ein wesentlicher Bestandteil der Fahrzeugdiagnose und ermöglichen es, verschiedene Diagnosedienste auf einer elektronischen Steuereinheit (ECU) zu implementieren. Diese Dokumentation bietet eine umfassende und detaillierte Erklärung des Diagnosesitzungssteuerungsdienstes (0x10), einschließlich Zweck, Beschreibung, unterstützter Subfunktionen, Anforderungs- und Antwortnachrichtenrahmen sowie unterstützter negativer Rückmeldecodes (NRCs).

## 1. Zweck

Der Diagnosesitzungssteuerungsdienst (0x10) wird verwendet, um von einer Diagnosesitzung zu einer anderen zu wechseln. Verschiedene Sitzungen bieten unterschiedliche Diagnosefunktionen und Parameter, die je nach Nutzung, Standards, Empfehlungen oder Vorgaben des Original Equipment Manufacturer (OEM) variieren können.

## 2. Kurzbeschreibung

Dieser Dienst aktiviert einen Satz von zeitlichen Parametern, die von der Datenverbindungsschicht (Schicht 2 im OSI-Modell) abhängig sind. Es darf zu einem Zeitpunkt nur eine Sitzung aktiv sein. Wenn nach dem Hochfahren keine andere Sitzung aktiviert wurde, bleibt der Server in der Standardsitzung.

## 3. Unterstützte Subfunktionen

Der Dienst 0x10 unterstützt mehrere Subfunktionen, die verschiedene Sitzungen repräsentieren:

- **00**: Reserviert
- **01**: Standardsitzung (Default Session)
- **02**: Programmiersitzung (Programming Session)
- **03**: Erweiterte Diagnosesitzung (Extended Diagnostic Session)
- **04**: Sicherheitsdiagnosesitzung (Safety System Diagnostic Session)
- **05-3F**: Reserviert
- **40-5F**: Fahrzeugspezifisch (Vehicle Manufacturer Specific)
- **60-7E**: Systemlieferant spezifisch (System Supplier Specific)
- **7F**: Reserviert

## 4. Detaillierte Beschreibung

### Sitzungskontrolle

- **Aktivierung und Deaktivierung**: Der Dienst ermöglicht es, zwischen verschiedenen Sitzungen zu wechseln. Jede Sitzung aktiviert einen eigenen Satz von zeitlichen Parametern und Diagnosefunktionen. Es darf zu jedem Zeitpunkt nur eine Sitzung aktiv sein.
- **Initialisierung**: Nach dem Hochfahren befindet sich das Steuergerät in der Standardsitzung. Wenn keine andere Sitzung angefordert wird, bleibt diese Sitzung aktiv.
- **Diagnosefähigkeit**: Das Steuergerät muss in der Lage sein, Diagnosefunktionen unter normalen Betriebsbedingungen und unter anderen vom Fahrzeughersteller oder Systemlieferanten definierten Bedingungen bereitzustellen.
- **Anforderung einer bereits laufenden Sitzung**: Wenn der Tester eine bereits laufende Sitzung anfordert, sendet der Server eine positive Antwortnachricht und verhält sich gemäß den Eigenschaften der Sitzung.

### Subfunktion 00: Reserviert

Diese Subfunktion ist für zukünftige Erweiterungen oder spezifische Implementierungen reserviert und wird aktuell nicht verwendet.

### Subfunktion 01: Standardsitzung (Default Session)

Die Standardsitzung ist die Basissitzung nach dem Hochfahren des Steuergeräts. Sie bietet grundlegende Diagnosefunktionen und ist die Fallback-Sitzung.

### Subfunktion 02: Programmiersitzung (Programming Session)

Diese Sitzung wird verwendet, um Steuergeräte zu programmieren oder zu reflashen. Sie ermöglicht erweiterte Kommunikationsparameter und erfordert spezielle Sicherheitsmaßnahmen.

### Subfunktion 03: Erweiterte Diagnosesitzung (Extended Diagnostic Session)

Die erweiterte Diagnosesitzung bietet zusätzliche Diagnosefunktionen und erweiterte Kommunikationsparameter im Vergleich zur Standardsitzung.

### Subfunktion 04: Sicherheitsdiagnosesitzung (Safety System Diagnostic Session)

Diese Sitzung ist für die Diagnose von sicherheitskritischen Systemen vorgesehen und erfordert höchste Sicherheits- und Kommunikationsstandards.

### Sitzungsübergänge

- **Von Standardsitzung zu Standardsitzung**: Der Server initialisiert die Standardsitzung neu, ohne den nichtflüchtigen Speicher (NVM) zu beeinflussen.
- **Von Standardsitzung zu einer anderen Sitzung**: Der Server setzt nur die Ereignisse zurück, die im Server konfiguriert sind. Periodische Zeitplaner bleiben aktiv.
- **Kommunikationskontrolle und DTC-Einstellung**: Die Zustände der Kommunikationskontroll- und DTC-Einstellungsdienste bleiben unverändert. Normaler Kommunikation bleibt deaktiviert, wenn sie zum Zeitpunkt des Sitzungswechsels deaktiviert war.

### Übergangsbedingungen

- **Positive Antwort vor Aktivierung**: Bei Anforderung einer neuen Sitzung sendet der Server eine positive Antwort, bevor die Parameter der neuen Sitzung aktiv werden.
- **Beibehaltung der Sitzungscharakteristik**: Wenn eine bereits aktive Sitzung erneut angefordert wird, sendet der Server eine positive Antwort und die Sitzungseigenschaften bleiben unverändert.

## 5. Anforderungsnachrichtenrahmen

Die Anforderung einer Diagnosesitzung erfolgt durch das Senden einer Nachricht mit dem Service-Identifikator (SID) 0x10 und der entsprechenden Subfunktions-ID. Das Format der Anforderung lautet wie folgt:

```sh
[ 0x10, Subfunktions-ID ]
```

Beispiel für die Anforderung einer erweiterten Diagnosesitzung:

```sh
[ 0x10, 0x03 ]
```

## 6. Positive Antwortnachricht

Nach erfolgreicher Anforderung einer neuen Sitzung sendet der Server eine positive Antwortnachricht, bevor die neuen Sitzungsparameter aktiv werden. Das Format der positiven Antwort lautet wie folgt:

```sh
[ 0x50, Subfunktions-ID ]
```

Beispiel für die positive Antwort auf die Anforderung einer erweiterten Diagnosesitzung:

```sh
[ 0x50, 0x03 ]
```

## 7. Unterstützte Negative Response Codes (NRCs)

Negative Antwortcodes werden gesendet, wenn eine Anforderung nicht erfolgreich ist. Die folgenden NRCs sind für den Dienst 0x10 definiert:

- **12 – Subfunktion nicht unterstützt**: Wird gesendet, wenn eine nicht implementierte oder falsche Subfunktion angefordert wird.
- **13 – Falsche Nachrichtenlänge oder ungültiges Format**: Wird gesendet, wenn die Nachrichtenlänge oder das Format ungültig ist.
- **22 – Bedingungen nicht erfüllt**: Wird gesendet, wenn die Voraussetzungen für die Anforderung der Diagnosesitzungssteuerung nicht erfüllt sind.

### NRC-Nachrichtenrahmen

Das Format der negativen Antwort lautet wie folgt:

```sh
[ PCI-Länge, Negativer Antwort-SID, NRC-Code ]
```

Beispiel für eine negative Antwort auf eine ungültige Anforderung:

```sh
[ 0x03, 0x7F, 0x10, 0x12 ]  // Subfunktion nicht unterstützt
```

## 8. Negative Response Frame

### NRC 12: Subfunktion nicht unterstützt

Wenn eine nicht implementierte oder falsche Subfunktion angefordert wird, lautet die Antwort:

```sh
[ 0x03, 0x7F, 0x10, 0x12 ]
```

### NRC 13: Falsche Nachrichtenlänge

Wenn die Nachrichtenlänge oder das Format ungültig ist, lautet die Antwort:

```sh
[ 0x03, 0x7F, 0x10, 0x13 ]
```

### NRC 22: Bedingungen nicht erfüllt

Wenn die Bedingungen für die Anforderung nicht erfüllt sind, lautet die Antwort:

```sh
[ 0x03, 0x7F, 0x10, 0x22 ]
```

## Schlussfolgerung

Dieser Teil bietet eine detaillierte Übersicht über den Diagnosesitzungssteuerungsdienst (0x10) gemäß den UDS-Standards. Durch das Verständnis der verschiedenen Sitzungen, deren Anforderungen und die entsprechenden positiven und negativen Antwortnachrichten können Diagnosetechniker effektiv mit den verschiedenen Diagnosezuständen eines Fahrzeugs arbeiten. Es ist wichtig, die spezifischen Implementierungen und Anforderungen des jeweiligen Fahrzeugherstellers oder Systemlieferanten zu berücksichtigen, um die korrekte Anwendung dieses Dienstes sicherzustellen.
