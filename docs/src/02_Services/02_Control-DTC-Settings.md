# Control DTC Setting (0x85)

## Einleitung

Unified Diagnostic Services (UDS) ist ein Kommunikationsprotokoll, das in der Automobildiagnose verwendet wird. Der Dienst "Control DTC Setting" (Dienst-ID 0x85) ermöglicht es einem Tester, das Setzen von Diagnostischen Fehlercodes (DTCs) in einem Steuergerät (ECU) zu steuern, indem das Aktualisieren der Statusbits für diese Fehlercodes angehalten oder fortgesetzt wird.

## Zweck des Dienstes

Der Hauptzweck des Dienstes "Control DTC Setting" besteht darin, das Speichern der aktuellen Datenwerte (DTC-Statusbits) im Steuergerät zu suspendieren oder temporär zu stoppen. Dies kann notwendig sein, wenn der Tester Diagnosen durchführt und verhindern möchte, dass bestimmte Fehlercodes während dieser Zeit gespeichert werden.

## Funktionsweise

- **Anhalten des DTC-Setzens:** Der Tester kann das Setzen der DTC-Statusbits anhalten. Wenn das Steuergerät diese Funktion nicht unterstützt, wird eine negative Antwort gesendet.
- **Fortsetzen des DTC-Setzens:** Falls der Tester einen Zustand anfordert, der bereits aktiv ist, wird eine positive Antwort gesendet.

Dieser Dienst deaktiviert nicht die Sicherheitsmodi des Fahrzeugs, sondern suspendiert lediglich das Aktualisieren der DTC-Statusbits.

## Unterfunktionen

Der Dienst hat verschiedene Unterfunktionen, die durch Enum-Werte dargestellt werden:

- **0x00:** SAE Reserviert
- **0x01:** An (DTC-Setzen wird fortgesetzt)
- **0x02:** Aus (DTC-Setzen wird angehalten)
- **0x03 bis 0x3F:** SAE Reserviert
- **0x40 bis 0x5F:** OEM-spezifisch
- **0x60 bis 0x7E:** Lieferantenspezifisch
- **0x7F:** SAE Reserviert

## Nachrichtenrahmen

- **Anforderungsrahmen:**
  1. Dienst-ID
  2. Unterfunktion (DTC-Einstellung: Stop oder Fortsetzen)
  3. DTC Setting Control Option Record (optional)

- **Positive Antwort:**
  1. Dienst-ID
  2. Unterfunktion (DTC-Einstellung: Stop oder Fortsetzen)
  3. DTC Setting Control Option Record (falls vorhanden)

- **Negative Antwort:**
  1. Negative Antwortkennung (7F)
  2. Dienst-ID
  3. Fehlercode (NRC Code)

## DTC Setting Control Option Record

Dies ist ein optionales Datenfeld, das vom Tester an das Steuergerät gesendet wird, um die spezifischen DTC-Statusbits zu kontrollieren, die ein- oder ausgeschaltet werden sollen.

## Bedingungen für die Fortsetzung des DTC-Setzens

Das Steuergerät wird das Setzen der DTCs unter folgenden Bedingungen fortsetzen:

1. Anforderung zur Wiederaufnahme (Unterfunktion: Resume)
2. ECU-Reset
3. Übergang zu einer Session, in der der Dienst (0x85) nicht unterstützt wird
4. Löschen der DTC-Informationen

## Angenommene Szenarien

Ein Tester möchte beispielsweise Fehler außer dem Airbag-Fehler (DTC: 4A 1B 33) diagnostizieren. Dazu wird dieser spezifische DTC mit der Unterfunktion 0x02 ausgeschaltet. In diesem Zustand wird der Statusbit-Update für diesen DTC ausgesetzt und nicht erneut protokolliert. Andere DTCs, die aufgrund des ausgeschalteten DTCs unterdrückt werden, sind zum Beispiel:

- **2F 01 00:** Bremsfehler
- **11 3D 11:** Kameraobjektivanpassung erforderlich
- **16 21 1F:** Funkenzündung beschädigt
- **10 1B 1A:** Reifendruck unter dem Schwellenwert

## Fehlercodes (NRCs)

Negative Antwortcodes (NRCs) informieren über die Gründe für das Scheitern einer Anfrage:

- **0x12:** Unterfunktion nicht unterstützt
- **0x13:** Falsche Nachrichtenlänge
- **0x22:** Bedingungen nicht erfüllt
- **0x31:** Anforderung außerhalb des Bereichs

**Beschreibung der einzelnen NRCs:**

- **0x12:** Wird gesendet, wenn die angeforderte Unterfunktion nicht unterstützt wird.
- **0x13:** Wird gesendet, wenn die Nachrichtenlänge nicht korrekt ist.
- **0x22:** Wird gesendet, wenn die Bedingungen für die Anforderung nicht erfüllt sind, z. B. wenn die Betriebsbedingungen oder internen Bedingungen des Servers nicht erfüllt sind, oder wenn der Server in einem kritischen Modus ist.
- **0x31:** Wird gesendet, wenn die Anforderung außerhalb des unterstützten Bereichs liegt, z. B. bei nicht unterstützten DTCs.