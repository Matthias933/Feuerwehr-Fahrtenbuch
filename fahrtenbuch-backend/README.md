### Feuerwehr Fahrtenbuch Backend

Das Backend ist die Schnittestelle zwischen Datenbank und Frontend. 
Es ist eine REST basierende Schnittstelle die mit NodeJS erstellt wurde.

#### Starten ####
Es muss NodeJS auf dem Rechner installiert sein und im Pfad vorhanden sein.
Die Verzeichnisse "dist" und "node_modules" müssen nebeneinander im selben Verzeichnis liegen.

node dist/main.js 

startet das Programm.
Beim ersten mal starten wird ein neues Verzeichnis data angelegt. In diesem Verzeichnis liegt dann die SQLite Datenbank
in der die Werte gespeichert werden. 
Diese Datei sollte regelmässig gesichert werden.


