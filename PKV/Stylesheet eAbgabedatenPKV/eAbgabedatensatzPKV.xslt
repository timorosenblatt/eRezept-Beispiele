<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:fhir="http://hl7.org/fhir" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xd fhir xsi xhtml" version="1.0">	<xsl:template match="/">		<xsl:apply-templates select="/fhir:Bundle"/>	</xsl:template>	<xsl:template match="fhir:Bundle[not(ancestor::fhir:Bundle)]">		<html lang="de" xmlns="http://www.w3.org/1999/xhtml">			<head>				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>				<title>					<xsl:value-of select="fhir:entry/fhir:resource/fhir:Composition/fhir:title/@value"/>				</title>				<style type="text/css" media="all">					@media print{						@page {								size: A4;								margin: 0;							}					}					html {						height: 100%;					}					body {						padding-left:2em;						padding-right:2em;						margin-top:1em;						height: 100%;					}					p {						<!--font-family: "Courier New", "Nimbus Mono L", monospace;-->						font-size: 16px;						margin:0;						paddin:0;					}					.in-black {						font-size: 7pt;						color: #000000;						font-weight: normal;						font-family: Arial, "Helvetica CY", "Nimbus Sans L", sans-serif;					}					.tiny {						font-size: 7pt;						color: #000000;						font-weight: bold;						font-weight: normal;						font-family: Arial, "Helvetica CY", "Nimbus Sans L", sans-serif;					}					.daten {						font-family: "Courier New", "Nimbus Mono L", monospace;						font-size: 12pt;					}					.nowrap {						white-space: nowrap;					}					.overflow {						overflow:hidden					}					.thin-space {						font-size: 12pt;						font-weight: normal;						font-family: Arial, "Helvetica CY", "Nimbus Sans L", sans-serif;					}					<!-- ****************************************** -->					ul {						list-style-type:none;						margin:0;						padding:0;					}					#gesamtrahmen {						border:1px solid black;						<!--width:55em;-->						background-color: rgb(198, 223, 253);					}					#kaestchen_bereich_links {						float:left;						padding-top:1em;					}					.kaestchen {						display: inline-flex;						font-size:2em;						font-weight: normal;						line-height:0.7;						align:center;					}					.mittig {						text-align:center;					}					.abstand_unten {						margin-bottom:1em;					}					.kein_abstand, h1 {						margin:0;						padding:0;					}					.abstand_links {						padding-left:10px;					}					table {						border-collapse:collapse;					}					thead {						background-color:black;						color:rgb(255, 204, 204);					}					td {						vertical-align:baseline;						border:1px solid grey;					}					h1 {						font-size:18px;						font-weight: bold;					}					.abstand_oben {						margin-top:1em;					}					.schrift_grau {						color:grey;					}					.fliessend {						float:right;					}					.hg_weiss {						background-color:white;					}					.abstand_links {						margin-left:20px;					}					.abstand_oben {						padding-top:20px;					}				</style>			</head>			<body>				<div id="gesamtrahmen">					<div class="fliessend">                        <b><u>abgebende Apotheke:</u></b>						<br/>						<b>IKNR:</b>&#160;<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:identifier/fhir:value/@value"/>						<br/><br/>						<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:name/@value"/>						<br/>						<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:address/fhir:line/@value"/>						<br/>						<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:address/fhir:country/@value"/>						&#160;						<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:address/fhir:postalCode/@value"/>						&#160;						<xsl:value-of select="fhir:entry/fhir:resource/fhir:Organization/fhir:address/fhir:city/@value"/>						<br/><br/>						<xsl:apply-templates select="fhir:entry/fhir:resource/fhir:Organization/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-PKV-EX-ERP-Bankverbindung']"/>					</div>					<div>						<p><b>PKV-Abgabeinformationen für Abgabe</b> am							<xsl:call-template name="formatDate">								<xsl:with-param name="date" select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:whenHandedOver/@value"/>							</xsl:call-template>							<xsl:variable name="vertragskennzeichen" select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Vertragskennzeichen']/fhir:valueString/@value"/>							<xsl:choose>                                <xsl:when test="$vertragskennzeichen!=''"> nach <b>Vertragskennzeichen: </b></xsl:when>							</xsl:choose>							<xsl:value-of select=" ($vertragskennzeichen) " />							<xsl:apply-templates select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-PKV-EX-ERP-AbrechnungsTyp']"/>							<br/>						</p>						<table width="80%">							<thead>								<tr>									<th>Position</th>									<th>PZN / SKZ /<br/>HMNR</th>									<th>Preiskomponente</th>									<th>Zusatzattribute</th>								</tr>							</thead>							<tbody>								<xsl:apply-templates select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Abrechnungszeilen']" mode="verweis"/>								<xsl:apply-templates select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-ZusatzdatenHerstellung']"/>								<xsl:apply-templates select="fhir:entry/fhir:resource/fhir:MedicationDispense[fhir:type/fhir:coding/fhir:code/@value='Abgabeinformationen']/fhir:substitution/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Rezeptaenderung']"/>							</tbody>						</table>						<div class="fliessend">							RezID:&#160;							<xsl:value-of select="//fhir:Bundle/fhir:identifier/fhir:value/@value"/>							&#160;AbgabedatenPKV:&#160;							<xsl:call-template name="getVersion">								<xsl:with-param name="url" select="//fhir:Bundle/fhir:meta/fhir:profile/@value"/>							</xsl:call-template>						</div>					</div>				</div>			</body>		</html>	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Abrechnungszeilen']" mode="verweis">		<xsl:variable name="test" select="fhir:valueReference/fhir:reference/@value"/>		<xsl:apply-templates select="/fhir:Bundle/fhir:entry[fhir:fullUrl/@value=$test]/fhir:resource/fhir:Invoice" mode="resource"/>		<!--<xsl:apply-templates select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Invoice" mode="resource"/>-->	</xsl:template> <!-- mode="verweis" -->	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-ZusatzdatenHerstellung']">		<tr>			<td colspan="4" class="abstand_oben">				<!--<h1 class="abstand_oben">Zusatzdatenherstellung <i class="schrift_grau">(<xsl:value-of select="fhir:valueReference/fhir:reference/@value"/>)</i></h1>-->				<b>Zusatzdatenherstellung</b>&#160;<i class="schrift_grau">(<xsl:value-of select="fhir:valueReference/fhir:reference/@value"/>)</i>			</td>		</tr>		<xsl:variable name="id_rechnung" select="fhir:valueReference/fhir:reference/@value"/>		<xsl:apply-templates select="/fhir:Bundle/fhir:entry[fhir:fullUrl/@value=$id_rechnung]/fhir:resource/fhir:MedicationDispense" mode="resource"/>	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Rezeptaenderung']">		<tr>			<td colspan="4" class="abstand_oben"><b>Rezeptänderung</b>&#160;am				<xsl:call-template name="formatDate">					<xsl:with-param name="date" select="fhir:extension[@url='DatumRezeptaenderung']/fhir:valueDate/@value"/>				</xsl:call-template>				&#160;durch&#160;				<xsl:apply-templates select="fhir:extension[@url='ArtRezeptaenderung']"/>			</td>		</tr>		<tr>			<td colspan="4">				<xsl:apply-templates select="fhir:extension[@url='RueckspracheArzt']"/>			</td>		</tr>		<xsl:if test="fhir:extension[@url='DokumentationRezeptaenderung']">			<tr>				<td colspan="4">					Dokumentation:&#160;<xsl:value-of select="fhir:extension[@url='DokumentationRezeptaenderung']/fhir:valueString/@value"/>				</td>			</tr>		</xsl:if>	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-PKV-EX-ERP-Bankverbindung']">        <b>Kontoinhaber:</b>&#160;<xsl:value-of select="fhir:extension[@url='Kontoinhaber']/fhir:valueString/@value"/>		<br/>        <b>IBAN:</b>&#160;<xsl:value-of select="fhir:extension[@url='IBAN']/fhir:valueString/@value"/>		<br/>        <b>BIC:</b>&#160;<xsl:value-of select="fhir:extension[@url='BIC']/fhir:valueString/@value"/>	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-PKV-EX-ERP-AbrechnungsTyp']">		<b>&#160;AbrechnungsTyp:&#160;</b>		<xsl:variable name="AbrechnungsTyp" select="fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>		<xsl:choose>			<xsl:when test="$AbrechnungsTyp='1'">Standard</xsl:when>			<xsl:when test="$AbrechnungsTyp='2'">Direktabrechnung</xsl:when>		</xsl:choose>		<br/>	</xsl:template>	<xsl:template match="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Invoice" mode="resource">		<tr><td colspan="4"><b><xsl:value-of select="fhir:type/fhir:coding/fhir:code/@value"/></b></td></tr>		<xsl:if test="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Zaehler']">	<!-- bei Auflistung von "Einzelpositionen" Zusatzdatenherstellung -->			<tr>				<td colspan="4"><xsl:apply-templates select="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Zaehler']"/></td>			</tr>		</xsl:if>		<xsl:if test="fhir:totalGross">		<!-- bei Zusammenfassung der gesamten Abgabe -->			<tr>				<td colspan="2">gesamte Abgabe</td>				<td>					<!--<table>-->						<xsl:apply-templates select="fhir:totalGross"/>						<xsl:apply-templates select="fhir:totalGross/fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Gesamtzuzahlung']"/>					<!--</table>-->				</td>				<td>&#160;</td>			</tr>		</xsl:if>		<xsl:apply-templates select="fhir:lineItem"/>	</xsl:template> <!-- mode="resource_Abgabe" + weitere mit gleichem match und mode="resource_ZusatzdatenHerstellung" + ggf. weitere resource_ZusatzdatenIrgendwas ... resource könnte ggf. auch gleich rechnung oder invoice heißen ... -->	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Zaehler']">		Zählernummer&#160;		<xsl:value-of select="fhir:valuePositiveInt/@value"/>	</xsl:template>	<xsl:template match="fhir:totalGross">		<xsl:value-of select="translate(fhir:value/@value, '.', ',')"/>&#160;		<xsl:value-of select="fhir:currency/@value"/>	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Gesamtzuzahlung']">		<p class="abstand_links">			Gesamtzuzahlung:&#160;			<xsl:value-of select="translate(fhir:valueMoney/fhir:value/@value, '.', ',')"/>&#160;			<xsl:value-of select="fhir:valueMoney/fhir:currency/@value"/>		</p>	</xsl:template>	<xsl:template match="fhir:lineItem">		<!--<table>			<tr>				<th>Position</th>				<th>PZN</th>				<th>Preiskomponente</th>				<th>Zusatzattribute</th>			</tr>-->		<tr>			<td><xsl:value-of select="fhir:sequence/@value"/></td>			<td>				<xsl:value-of select="fhir:chargeItemCodeableConcept/fhir:coding/fhir:code/@value"/>&#160;				<xsl:variable name="cs" select="fhir:chargeItemCodeableConcept/fhir:coding/fhir:system/@value"/>				<xsl:choose>					<xsl:when test="$cs='http://fhir.de/CodeSystem/ifa/pzn'">(PZN)</xsl:when>					<xsl:when test="$cs='http://TA1.abda.de'">(SKZ)</xsl:when>					<xsl:when test="$cs='http://fhir.de/sid/gkv/hmnr'">(HMNR)</xsl:when>				</xsl:choose>				<br></br>				<xsl:value-of select="fhir:chargeItemCodeableConcept/fhir:text/@value"/>			</td>			<td><xsl:apply-templates select="fhir:priceComponent"/></td>			<td>				<xsl:if test="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Zusatzattribute']">					<table width="100%">						<tbody>							<xsl:apply-templates select="fhir:extension/fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='11']"/>							<xsl:apply-templates select="fhir:extension/fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='12']"/>							<xsl:apply-templates select="fhir:extension/fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='16']"/>							<xsl:apply-templates select="fhir:extension/fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='101']"/>						</tbody>					</table>				</xsl:if>			</td>		</tr>		<!--</table>-->	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-MwStSatz']">		&#160;(MwSt:&#160;		<xsl:value-of select="translate(fhir:valueDecimal/@value, '.', ',')"/>)	</xsl:template>	<xsl:template match="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-KostenVersicherter']">		<xsl:value-of select="translate(fhir:extension[@url='Kostenbetrag']/fhir:valueMoney/fhir:value/@value, '.', ',')"/>		&#160;		<xsl:value-of select="fhir:extension[@url='Kostenbetrag']/fhir:valueMoney/fhir:currency/@value"/>		&#160;		<xsl:variable name="kategorie" select="fhir:extension[@url='Kategorie']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>		<xsl:choose>			<xsl:when test="$kategorie='0'">Zuzahlung</xsl:when>		</xsl:choose>		<br/>	</xsl:template>	<xsl:template match="fhir:priceComponent">		<xsl:value-of select="translate(fhir:amount/fhir:value/@value, '.', ',')"/>		&#160;		<xsl:value-of select="fhir:amount/fhir:currency/@value"/>		<xsl:variable name="faktor" select="fhir:factor/@value"/>		<xsl:choose>			<xsl:when test="$faktor!=''">,&#160;Menge&#160;=&#160;</xsl:when>		</xsl:choose>		<xsl:value-of select=" ($faktor) " />		&#160;		<xsl:variable name="faktorkennzeichen" select="fhir:extension/fhir:valueCodeableConcept/fhir:coding[fhir:system/@value='http://fhir.abda.de/eRezeptAbgabedaten/CodeSystem/DAV-PKV-CS-ERP-ZusatzdatenEinheitFaktorkennzeichen']/fhir:code/@value"/>		<xsl:choose>			<xsl:when test="$faktorkennzeichen='11'">Anteil in Promille</xsl:when> 					<!-- (Kennzeichen für verarbeitete Packungen oder Teilmengen von Packungen, Stoffen, Gefäßen oder für Zuschläge) -->			<xsl:when test="$faktorkennzeichen='99'">Anteil einer Packung in Promille (Verwurf)</xsl:when>		</xsl:choose>	</xsl:template>	<xsl:template match="fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='11']"> <!-- Abgabe im Notdienst -->		<tr><td>Abgabe im Notdienst</td><td>			<!--xsl:variable name="schluessel" select="fhir:extension[@url='Schluessel']/fhir:valueBoolean/@value"/>			<xsl:choose>				<xsl:when test="$schluessel='true'">ja</xsl:when>			</xsl:choose-->			<xsl:if test="fhir:extension[@url='DatumUhrzeit']">				<br/>am&#160;				<xsl:call-template name="formatDate">					<xsl:with-param name="date" select="fhir:extension[@url='DatumUhrzeit']/fhir:valueDateTime/@value"/>				</xsl:call-template><br/>um&#160;				<xsl:call-template name="formatTime">					<xsl:with-param name="date" select="fhir:extension[@url='DatumUhrzeit']/fhir:valueDateTime/@value"/>				</xsl:call-template>			</xsl:if>		</td></tr>	</xsl:template>	<xsl:template match="fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='12']"> <!-- Zusätzliche Abgabeangaben -->		<tr><td>Zusätzliche Abgabeangaben</td><td>			<!--xsl:variable name="schluessel" select="fhir:extension[@url='Schluessel']/fhir:valueBoolean/@value"/>			<xsl:choose>				<xsl:when test="$schluessel='true'">ja</xsl:when>			</xsl:choose-->			<xsl:if test="fhir:extension[@url='DokumentationFreitext']">				<br/>				<xsl:value-of select="fhir:extension[@url='DokumentationFreitext']/fhir:valueString/@value"/>			</xsl:if>		</td></tr>	</xsl:template>	<xsl:template match="fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='16']"> <!-- Teilmengenabgabe -->		<tr><td>Teilmengenabgabe</td><td>			<!--			<xsl:variable name="schluessel" select="fhir:extension[@url='Schluessel']/fhir:valueBoolean/@value"/>			<xsl:choose>				<xsl:when test="$schluessel='true'">ja</xsl:when>			</xsl:choose>			-->			<xsl:if test="fhir:extension[@url='Spender-PZN']">				Spender-PZN:&#160;				<xsl:value-of select="fhir:extension[@url='Spender-PZN']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>			</xsl:if>		</td></tr>	</xsl:template>	<xsl:template match="fhir:extension[fhir:extension[@url='Gruppe']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value='101']"> <!-- Aut idem Austausch -->		<tr><td>AutidemAustausch</td><td>			<xsl:variable name="schluessel" select="fhir:extension[@url='Schluessel']/fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>			<xsl:choose>				<xsl:when test="$schluessel='1'">Patientenwunsch</xsl:when>				<xsl:when test="$schluessel='2'">Nicht-Verfügbarkeit</xsl:when>				<xsl:when test="$schluessel='3'">dringender Fall</xsl:when>				<xsl:when test="$schluessel='4'">sonstige Bedenken</xsl:when>			</xsl:choose>			<xsl:if test="fhir:extension[@url='DokumentationFreitext']">				<br/>				<xsl:value-of select="fhir:extension[@url='DokumentationFreitext']/fhir:valueString/@value"/>			</xsl:if>		</td></tr>	</xsl:template>	<xsl:template match="/fhir:Bundle/fhir:entry/fhir:resource/fhir:MedicationDispense" mode="resource">		<tr>			<td colspan="4">				<b>Herstellungsvorgang Nummer					<xsl:value-of select="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-Zaehler']/fhir:valuePositiveInt/@value"/>				</b>				<!--				Zubereitung am				<xsl:call-template name="formatDate">					<xsl:with-param name="date" select="fhir:whenPrepared/@value"/>				</xsl:call-template>				um				<xsl:call-template name="formatTime">					<xsl:with-param name="date" select="fhir:whenPrepared/@value"/>				</xsl:call-template>				in				<xsl:choose>					<xsl:when test="fhir:performer/fhir:function/fhir:coding/fhir:code/@value='1'">Eigenfertigung</xsl:when>					<xsl:when test="fhir:performer/fhir:function/fhir:coding/fhir:code/@value='2'">Fremdfertigung</xsl:when>				</xsl:choose>				<xsl:apply-templates select="fhir:performer/fhir:actor"/>				-->			</td>		</tr>		<xsl:variable name="id_rechnung" select="fhir:extension[@url='http://fhir.abda.de/eRezeptAbgabedaten/StructureDefinition/DAV-EX-ERP-ZusatzdatenEinheit']/fhir:valueReference/fhir:reference/@value"/>		<xsl:apply-templates select="/fhir:Bundle/fhir:entry[fhir:fullUrl/@value=$id_rechnung]/fhir:resource/fhir:Invoice" mode="resource"/>	</xsl:template>	<!-- Templates für Rezeptänderungen -->	<xsl:template match="fhir:extension[@url='ArtRezeptaenderung']">		<xsl:variable name="aenderungsart" select="fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>		<xsl:choose>			<xsl:when test="$aenderungsart='1'">Abweichung von der Verordnung bzgl. der Darreichungsform bei Fertigarzneimitteln</xsl:when>			<xsl:when test="$aenderungsart='2'">Korrektur / Ergänzung der Darreichungsform bei Rezepturen</xsl:when>			<xsl:when test="$aenderungsart='3'">Korrektur / Ergänzung der Gebrauchsanweisung bei einer Rezeptur</xsl:when>			<xsl:when test="$aenderungsart='4'">Korrektur / Ergänzung der Dosierungsanweisung</xsl:when>			<xsl:when test="$aenderungsart='5'">Ergänzung eines fehlenden Hinweises auf einen Medikationsplan, der das verschriebene Arzneimittel umfasst, oder auf eine schriftliche Dosierungsanweisung</xsl:when>			<xsl:when test="$aenderungsart='6'">Abweichung von der Verordnung bzgl. der Bezeichnung des Fertigarzneimittels</xsl:when>			<xsl:when test="$aenderungsart='7'">Abweichung von der Verordnung bzgl. der Bezeichnung des Wirkstoffs bei einer Wirkstoffverordnung</xsl:when>			<xsl:when test="$aenderungsart='8'">Abweichung von der Verordnung bzgl. der Stärke eines Fertigarzneimittels oder Wirkstoffs</xsl:when>			<xsl:when test="$aenderungsart='9'">Abweichung von der Verordnung bzgl. der Zusammensetzung von Rezepturen nach Art und Menge</xsl:when>			<xsl:when test="$aenderungsart='10'">Abweichung von der Verordnung bzgl. der abzugebenden Menge</xsl:when>			<xsl:when test="$aenderungsart='11'">Abweichung von der Verordnung bzgl. der abzugebenden Rezepturmenge auf eine Reichdauer bis zu 7 Tagen bei Entlassverordnung</xsl:when>			<xsl:when test="$aenderungsart='12'">Freitextliche Dokumentation der Änderung wenn keiner der anderen Schlüssel / Fälle vorliegt</xsl:when>			<xsl:when test="$aenderungsart='13'">Abweichung von der Verordnung aufgrund von Lieferengpässen ggfls. mit Dosierungsänderungen</xsl:when>			<xsl:when test="$aenderungsart='14'">Austausch aufgrund der Dringlichkeitsliste ggfls. mit Dosierungsänderungen</xsl:when>			<xsl:when test="$aenderungsart='21'">Abweichung von der Packungsgröße bzw. Packungsanzahl aufgrund von Nichtverfügbarkeit und dringendem Fall bei der Dienstbereitschaft</xsl:when>		</xsl:choose>	</xsl:template>	<xsl:template match="fhir:extension[@url='RueckspracheArzt']">		<xsl:variable name="ruecksprache" select="fhir:valueCodeableConcept/fhir:coding/fhir:code/@value"/>		<xsl:choose>			<xsl:when test="$ruecksprache='0'">Rücksprache mit dem Arzt ist erfolgt.</xsl:when>			<xsl:when test="$ruecksprache='1'">Dringender Fall, Rücksprache mit dem Arzt war nicht möglich.</xsl:when>			<xsl:when test="$ruecksprache='2'">Keine Rücksprache mit dem Arzt erforderlich.</xsl:when>		</xsl:choose>	</xsl:template>	<!-- Templates für Funktionen -->	<xsl:template name="formatDate">		<xsl:param name="date"/>		<xsl:variable name="yearNum" select="substring ($date, 1, 4)"/>		<xsl:variable name="monthNum" select="substring ($date, 6, 2)"/>		<xsl:variable name="dayNum" select="substring ($date, 9, 2)"/>		<xsl:if test="$dayNum!=''">			<xsl:value-of select="$dayNum"/>			<xsl:text>.</xsl:text>		</xsl:if>		<xsl:if test="$dayNum!=''">			<xsl:value-of select="$monthNum"/>			<xsl:text>.</xsl:text>		</xsl:if>		<xsl:value-of select="$yearNum"/>	</xsl:template>	<xsl:template name="formatTime">		<xsl:param name="date"/>		<xsl:value-of select="substring($date, 12, 8)"/> Uhr	</xsl:template>	<xsl:template name="substring-after-last">		<xsl:param name="input"/>		<xsl:param name="substr"/>		<xsl:variable name="lastChar" select="substring($input, string-length($input) - string-length($substr) +1)"/>		<xsl:choose>			<xsl:when test="$lastChar=$substr">				<xsl:call-template name="substring-after-last">					<xsl:with-param name="input" select="substring($input,1, string-length($input)-1)"/>					<xsl:with-param name="substr" select="$substr"/>				</xsl:call-template>			</xsl:when>			<xsl:otherwise>				<!-- Extract the string which comes after the first occurence -->				<xsl:variable name="temp" select="substring-after($input,$substr)"/>				<xsl:choose>					<!-- If it still contains the search string the recursively process -->					<xsl:when test="$substr and  contains($temp,$substr)">						<xsl:call-template name="substring-after-last">							<xsl:with-param name="input" select="$temp"/>							<xsl:with-param name="substr" select="$substr"/>						</xsl:call-template>					</xsl:when>					<xsl:otherwise>						<xsl:if test="contains($temp,'/')">							<xsl:call-template name="substring-after-last">								<xsl:with-param name="input" select="$temp"/>								<xsl:with-param name="substr" select="$substr"/>							</xsl:call-template>						</xsl:if>						<xsl:value-of select="$temp"/>					</xsl:otherwise>				</xsl:choose>			</xsl:otherwise>		</xsl:choose>	</xsl:template>	<xsl:template name="getVersion">		<xsl:param name="url"/>		<xsl:variable name="version" select="substring-after($url,'|')"/>		<xsl:value-of select="$version"/>	</xsl:template>	<xsl:template name="getPossibleEmptyValue">		<xsl:param name="path"/>		<xsl:choose>			<xsl:when test="$path">				<xsl:value-of select="$path"/>				<text>&#160;</text>			</xsl:when>		</xsl:choose>	</xsl:template></xsl:stylesheet>