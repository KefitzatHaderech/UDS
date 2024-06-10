# Security Access

## Einführung

Unified Diagnostic Services (UDS) ist ein in der Automobilindustrie weit verbreitetes Protokoll zur Diagnose und Programmierung von Fahrzeugkomponenten. Der Security Access ist ein entscheidender Bestandteil dieses Protokolls, der den Zugriff auf kritische Daten und Funktionen schützt. Diese Dokumentation bietet eine umfassende Analyse der in der bereitgestellten PDF-Datei enthaltenen Informationen zu Security Access und korrigiert eventuelle Ungenauigkeiten oder Missverständnisse.

## Ziel des Security Access

Security Access dient dem Schutz folgender Elemente:

- **Daten/Informationen**
- **Diagnosedienste**

Die Notwendigkeit von Security Access ergibt sich aus der Sensibilität bestimmter Daten und Funktionen. Unsachgemäße Handhabung kann schwerwiegende Schäden an der Elektronik (z.B. Motherboard) oder die Beschädigung der gesamten Software und anderer Fahrzeugkomponenten verursachen. Um solche Risiken zu vermeiden, ist Security Access unerlässlich.

## Algorithmus

Der Sicherheitsmechanismus verwendet einen Seed-and-Key-Algorithmus. Der Ablauf des Security Access ist wie folgt:

1. Der Client fordert einen „Seed“ an.
2. Der Server antwortet mit dem „Seed“.
3. Der Client sendet den entsprechenden „Key“ zum erhaltenen „Seed“.
4. Der Server prüft den „Key“. Bei einem gültigen „Key“ entsperrt sich der Server, andernfalls antwortet er mit einem negativen Antwortcode (NRC).

## Key-Strukturen

Der Sicherheitszugriffsschlüssel kann in verschiedenen Formaten vorliegen:

- Intern gespeicherter Wert
- Verschlüsselter Wert
- Berechneter Wert

## Sub-Funktionen des Security Access

Security Access unterteilt sich in verschiedene Sub-Funktionen, die unterschiedliche Sicherheitsstufen darstellen:

- **Seed anfordern** (z.B. 0x01, 0x03, 0x05..0x41)
- **Key senden** (z.B. 0x02, 0x04, 0x06..0x42)

## Beispiel für Berechnung des Security Access

Angenommene Seed-Werte und deren Berechnung:

- Seed: 1A 29 (hex)
  - Binär: 0001 1010 0010 1001
  - 1’s Komplement: 1110 0101 1101 0110
  - 2’s Komplement: 1110 0101 1101 0111 (E5 97 hex)
- Berechneter Key: E5 97

## Sicherheitsstufen und deren Zweck

Jede Sicherheitsstufe hat einen spezifischen Zweck. Es ist wichtig zu beachten, dass immer nur eine Sicherheitsstufe aktiv sein darf. Bei mehrfachen Sicherheitsanforderungen entsperrt der Tester nur eine Ebene zur Zeit.

## Verhalten des Steuergeräts bei Sicherheitsanforderungen

1. **Bereits entsperrte Sicherheitsstufe:** Wenn die Sicherheitsstufe bereits entsperrt ist, antwortet das Steuergerät mit einem Seed-Wert von null.
2. **Ungültiger Schlüssel:** Ein ungültiger Schlüssel erfordert, dass der Tester den Sicherheitszugriff von vorne beginnt.
3. **Zeitverzögerungen bei Fehlversuchen:** Bei wiederholten Fehlversuchen wird eine Zeitverzögerung aktiviert, um weitere Versuche zu unterbinden. Diese Verzögerung ist erforderlich, wenn der Server aufgrund misslungener Versuche gesperrt ist.

## Negative Antwortcodes (NRC) für 0x27

- **12 - Sub-Funktion nicht unterstützt:** Wenn eine nicht implementierte oder falsche Sub-Funktion gesendet wird.
- **13 - Falsche Nachrichtenlänge oder ungültiges Format:** Bei ungültiger oder falscher Anfrage.
- **22 - Bedingungen nicht erfüllt:** Wenn die Bedingungen für den Sicherheitszugriff nicht erfüllt sind.
- **24 - Anfragenfolgenfehler:** Wenn der Schlüssel direkt ohne vorherigen Seed gesendet wird.
- **31 - Anforderung außerhalb des Bereichs:** Bei ungültigen Daten.
- **35 - Ungültiger Schlüssel:** Wenn der Schlüsselwert nicht mit dem gespeicherten Wert übereinstimmt.
- **36 - Maximale Anzahl von Versuchen überschritten:** Bei Überschreitung der maximal zulässigen Fehlversuche.
- **37 - Erforderliche Zeitverzögerung nicht abgelaufen:** Wenn der Verzögerungstimer aktiv ist und eine Anfrage gesendet wird.

## Schlussfolgerung

Der Security Access im Rahmen des UDS-Protokolls ist eine essenzielle Sicherheitsmaßnahme zum Schutz kritischer Fahrzeugdaten und -funktionen. Durch die Implementierung eines Seed-and-Key-Algorithmus und spezifischer Sicherheitsstufen wird ein sicherer Zugang gewährleistet, während mögliche Missbrauchs- und Schadensrisiken minimiert werden. Es ist wichtig, dass die genauen Protokolle und Zeitverzögerungen gemäß den Anforderungen des Original Equipment Manufacturers (OEM) eingehalten werden, um die Integrität des Systems zu gewährleisten.
