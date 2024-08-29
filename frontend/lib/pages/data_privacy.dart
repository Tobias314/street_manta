import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class DataPrivacy extends StatelessWidget {
  const DataPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datenschutzerklärung'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            MarkdownBody(
              data: """
# I. Informationen über die Verarbeitung Ihrer Daten gemäß Art. 13 der Datenschutz-Grundverordnung (DS-GVO)
## 1. Verantwortlicher und Datenschutzbeauftragter

Verantwortlich für diese Website ist:

Tobias Pietz

Johannsenstr. 18

14482 Potsdam

E-Mail: redpielabs@gmail.com

Telefon: +49 163 4868916

## 2. Daten, die für die Bereitstellung der Website und die Erstellung der Protokolldateien verarbeitet werden


### a. Welche Daten werden für welchen Zweck verarbeitet?

Bei jedem Zugriff auf Inhalte der Website werden vorübergehend Daten gespeichert, die möglicherweise eine Identifizierung zulassen. Die folgenden Daten werden hierbei erhoben:

- Datum und Uhrzeit des Zugriffs

- IP-Adresse

- Hostname des zugreifenden Rechners

- Website, von der aus die Website aufgerufen wurde

- Websites, die über die Website aufgerufen werden

- Besuchte Seite auf unserer Website

- Meldung, ob der Abruf erfolgreich war

- Übertragene Datenmenge

- Informationen über den Browsertyp und die verwendete Version

- Betriebssystem

Die vorübergehende Speicherung der Daten ist für den Ablauf eines Websitebesuchs erforderlich, um eine Auslieferung der Website zu ermöglichen. Eine weitere Speicherung in Protokolldateien erfolgt, 
um die Funktionsfähigkeit der Website und die Sicherheit der informationstechnischen Systeme sicherzustellen. In diesen Zwecken liegt auch unser berechtigtes Interesse an der Datenverarbeitung.

Für registrierte Nutzer speichern und verarbeiten wir weiterhing folgende personenbezogene Daten:
  - E-Mail-Adresse
  - Verschlüsselte Passwörter


Diese Daten registrieter Nutzer werden gespeichert um eine Nutzerkontenverwaltung zu ermöglichen sowie die Datensicherheit durch Zugriffsbeschränkungen zu erhöhen 
worin auch das berechtigte Interesse an der Datenverarbeitung liegt.
Eine Weitergabe der Daten an Dritte erfolgt nicht.

### b. Auf welcher Rechtsgrundlage werden diese Daten verarbeitet?

Die Daten werden auf der Grundlage des Art. 6 Abs. 1 Buchstabe f DS-GVO verarbeitet.

### c. Wie lange werden die Daten gespeichert?

Die Daten werden gelöscht, sobald sie für die Erreichung des Zwecks ihrer Erhebung nicht mehr erforderlich sind. Bei der Bereitstellung der Website ist dies der Fall, wenn die jeweilige Sitzung beendet ist 
bzw. die Daten registrierter Nutzen nicht mehr im Rahmen der Nutzerkontenverwaltung benötigt werden.
Die Protokolldateien werden ausschließlich für Administratoren zugänglich aufbewahrt und nach 30 Tagen automatisch gelöscht. Eine Weitergabe an Dritte erfolgt nicht.

## 3. Betroffenenrechte

### a. Recht auf Auskunft

Sie können Auskunft nach Art. 15 DS-GVO über Ihre personenbezogenen Daten verlangen, die wir verarbeiten.

### b. Recht auf Widerspruch:

Sie haben ein Recht auf Widerspruch aus besonderen Gründen (siehe unter Punkt II).

### c. Recht auf Berichtigung

Sollten die Sie betreffenden Angaben nicht (mehr) zutreffend sein, können Sie nach Art. 16 DS-GVO eine Berichtigung verlangen. Sollten Ihre Daten unvollständig sein, können Sie eine Vervollständigung verlangen.

### d. Recht auf Löschung

Sie können nach Art. 17 DS-GVO die Löschung Ihrer personenbezogenen Daten verlangen.

### e. Recht auf Einschränkung der Verarbeitung

Sie haben nach Art. 18 DS-GVO das Recht, eine Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen.

###  f. Recht auf Beschwerde

Wenn Sie der Ansicht sind, dass die Verarbeitung Ihrer personenbezogenen Daten gegen Datenschutzrecht verstößt, haben Sie nach Ar. 77 Abs. 1 DS-GVO das Recht, sich bei einer Datenschutzaufsichtsbehörde eigener Wahl 
zu beschweren. Hierzu gehört auch die für den Verantwortlichen zuständige Datenschutzaufsichtsbehörde: Landesbeauftragte für Datenschutz und Informationsfreiheit Brandenburg, 
[https://www.lda.brandenburg.de/lda/de/ueber-uns/kontakt/](https://www.lda.brandenburg.de/lda/de/ueber-uns/kontakt/).

### g. Recht auf Datenübertragbarkeit

Für den Fall, dass die Voraussetzungen des Art. 20 Abs. 1 DS-GVO vorliegen, steht Ihnen das Recht zu, sich Daten, die wir auf Grundlage Ihrer Einwilligung oder in Erfüllung eines Vertrags automatisiert verarbeiten, 
an sich oder an Dritte aushändigen zu lassen. Die Erfassung der Daten zur Bereitstellung der Website und die Speicherung der Protokolldateien sind für den Betrieb der Internetseite zwingend erforderlich. 
Sie beruhen daher nicht auf einer Einwilligung nach Art. 6 Abs. 1 Buchstabe a DS-GVO oder auf einem Vertrag nach Art. 6 Abs. 1 Buchstabe b DS-GVO, sondern sind nach Art. 6 Abs. 1 Buchstabe f DS-GVO gerechtfertigt. 
Die Voraussetzungen des Art. 20 Abs. 1 DS-GVO sind demnach insoweit nicht erfüllt.

## 3. Von Nutzern hochgeladene und geteilte Bilder und Inhalte

Eine zentrale Funktion des angebotenen Dienstes ist die Möglichkeit, georeferenziert Bilder und andere Inhalte hochzuladen und zu teilen. 
Dabei wird der Standort des Nutzers zum Zeitpunk der Bildaufnahme erfasst und in Verbindung mit den hochgeladenen Bildern gespeichert.
Nutzer sollten darauf achten, keine personenbezogenen oder anderweitig sensitive Daten in den Bildern zu veröffentlichen. 
Für den Inhalt der Bilder wird von Seiten des Betreibers keine Haftung übernommen. Der Betreiber behält sich das Recht vor, Bilder und andere Daten einzusehen und zu löschen.

## 4. OpenStreetMap

Wir binden die Landkarten des Dienstes “OpenStreetMap” ein ([https://www.openstreetmap.org](https://www.openstreetmap.org)), 
die auf Grundlage der Open Data Commons Open Database Lizenz (ODbL) durch die OpenStreetMap Foundation (OSMF) angeboten werden. 
[Datenschutzerklärung der OSMF.](https://wiki.osmfoundation.org/wiki/Privacy_Policy)

Nach unserer Kenntnis werden die Daten der Nutzer durch OpenStreetMap ausschließlich zu Zwecken der Darstellung der Kartenfunktionen und Zwischenspeicherung der gewählten Einstellungen verwendet. 
Zu diesen Daten können insbesondere IP-Adressen und Standortdaten der Nutzer gehören, die jedoch nicht ohne deren Einwilligung (im Regelfall im Rahmen der Einstellungen ihrer Mobilgeräte vollzogen), erhoben werden.

# II. Recht auf Widerspruch gemäß Art. 21 Abs. 1 DS-GVO

Sie haben das Recht, aus Gründen, die sich aus Ihrer besonderen Situation ergeben, jederzeit gegen die Verarbeitung Ihrer personenbezogenen Daten, die aufgrund von Artikel 6 Abs. 1 Buchstabe f DS-GVO erfolgt, 
Widerspruch einzulegen. Der Verantwortliche verarbeitet die personenbezogenen Daten dann nicht mehr, es sei denn, er kann zwingende schutzwürdige Gründe für die Verarbeitung nachweisen, die die Interessen, 
Rechte und Freiheiten der betroffenen Person überwiegen, oder die Verarbeitung dient der Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen. Die Erfassung der Daten zur Bereitstellung der Website 
und die Speicherung der Protokolldateien sind für den Betrieb der Internetseite zwingend erforderlich.
""",
              onTapLink: (text, url, title) {
                launchUrl(
                    Uri.parse(url!)); /*For url_launcher 6.1.0 and higher*/
                // launch(url);  /*For url_launcher 6.0.20 and lower*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
