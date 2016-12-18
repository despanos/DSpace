<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <jmelo@lyncode.com>
	
	> http://www.openarchives.org/OAI/2.0/oai_dc.xsd

 -->
 <!-- authored by dspanos -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	xmlns:heal="http://seab.lib.ntua.gr/schemas/heal/"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" encoding="UTF-8"/>
	
	<xsl:template match="/">
		<heal:healMeta
			xmlns:heal="http://seab.lib.ntua.gr/schemas/heal/"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://seab.lib.ntua.gr/schemas/heal/ http://orpheus.cn.ntua.gr/schemas/heal/heal_v1.3.10.xsd">
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
				<heal:type>
					<xsl:choose>
						<xsl:when test="text() = 'Προπτυχιακή/Διπλωματική εργασία'">bachelorThesis</xsl:when>
						<xsl:when test="text() = 'Μεταπτυχιακή εργασία'">masterThesis</xsl:when>
						<xsl:when test="text() = 'Διδακτορική διατριβή'">doctoralThesis</xsl:when>
						<xsl:when test="text() = 'Δημοσίευση σε συνέδριο'">conferenceItem</xsl:when>
						<xsl:when test="text() = 'Δημοσίευση σε περιοδικό'">journalArticle</xsl:when>
						<xsl:when test="text() = 'Κεφάλαιο βιβλίου'">bookChapter</xsl:when>
						<xsl:when test="text() = 'Βιβλίο/Μονογραφία'">book</xsl:when>
						<xsl:when test="text() = 'Τεχνική αναφορά'">report</xsl:when>
						<xsl:when test="text() = 'Εκπαιδευτικό υλικό'">learningMaterial</xsl:when>
						<xsl:when test="text() = 'Σύνολο δεδομένων'">dataset</xsl:when>
						<xsl:when test="text() = 'Εικόνα'">image</xsl:when>
						<xsl:when test="text() = 'Βίντεο'">video</xsl:when>
						<xsl:when test="text() = 'Ήχος'">audio</xsl:when>
						<xsl:otherwise>other</xsl:otherwise>
					</xsl:choose>
				</heal:type>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
				<heal:title>
					<!-- append an xml:lang attribute only if the parent of the field element has a name attribute other than 'none' -->
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:title>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='secondaryTitle']/doc:element/doc:field[@name='value']">
				<heal:secondaryTitle>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:secondaryTitle>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field[@name='value']">
				<heal:creatorName>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:creatorName>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='creatorID']/doc:element/doc:element/doc:field[@name='value']">
				<heal:creatorID type="{../../@name}">
				<!--  <heal:creatorID>
					<xsl:attribute name="type"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
					<xsl:value-of select="." />
				</heal:creatorID>
			</xsl:for-each>
			<!-- unqualified creatorID elements map to heal.creatorID.other -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='creatorID']/doc:element/doc:field[@name='value']">
				<heal:creatorID type="other">
					<xsl:value-of select="." />
				</heal:creatorID>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
				<heal:generalDescription>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:generalDescription>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='classification']/doc:element/doc:element/doc:field[@name='value']">
				<heal:classification scheme="{../../@name}">
				<!--  <heal:classification>
					<xsl:attribute name="scheme"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:classification>
			</xsl:for-each>
			<!-- unqualified classification elements map to heal.classification.other -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='classification']/doc:element/doc:field[@name='value']">
				<heal:classification scheme="other">
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:classification>
			</xsl:for-each>
			
			<!-- both qualified and unqualified classificationURI elements map to heal.classificationURI -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='classificationURI']/doc:element/doc:element/doc:field[@name='value']">
				<heal:classificationURI>
					<xsl:value-of select="." />
				</heal:classificationURI>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='classificationURI']/doc:element/doc:field[@name='value']">
				<heal:classificationURI>
					<xsl:value-of select="." />
				</heal:classificationURI>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='keyword']/doc:element/doc:element/doc:field[@name='value']">
				<heal:keyword scheme="{../../@name}">
				<!--  <heal:keyword>
					<xsl:attribute name="scheme"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:keyword>
			</xsl:for-each>
			<!-- unqualified keyword elements as well as dc.subject values map to heal.keyword.other -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='keyword']/doc:element/doc:field[@name='value']">
				<heal:keyword scheme="other">
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:keyword>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
				<heal:keyword scheme="other">
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:keyword>
			</xsl:for-each>
			
			<!-- both qualified and unqualified keywordURI elements map to heal.keywordURI -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='keywordURI']/doc:element/doc:element/doc:field[@name='value']">
				<heal:keywordURI>
					<xsl:value-of select="." />
				</heal:keywordURI>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='keywordURI']/doc:element/doc:field[@name='value']">
				<heal:keywordURI>
					<xsl:value-of select="." />
				</heal:keywordURI>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']/doc:element[@name='spatial']/doc:element/doc:field[@name='value']">
				<heal:spatialCoverage>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:spatialCoverage>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']/doc:element[@name='temporal']/doc:element/doc:field[@name='value']">
				<heal:temporalCoverage>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:temporalCoverage>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='contributorName']/doc:element/doc:field[@name='value']">
				<heal:contributorName>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:contributorName>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='contributorID']/doc:element/doc:element/doc:field[@name='value']">
				<heal:contributorID type="{../../@name}">
				<!--  <heal:contributorID>
					<xsl:attribute name="type"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
					<xsl:value-of select="." />
				</heal:contributorID>
			</xsl:for-each>
			<!-- unqualified contributorID elements map to heal.contributorID.other -->
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='contributorID']/doc:element/doc:field[@name='value']">
				<heal:contributorID type="other">
					<xsl:value-of select="." />
				</heal:contributorID>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='identifierSecondary']/doc:element/doc:field[@name='value']">
				<heal:identifierSecondary>
					<xsl:value-of select="." />
				</heal:identifierSecondary>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']">
				<heal:dateAvailable>
					<xsl:value-of select="." />
				</heal:dateAvailable>
			</xsl:for-each>
			
			<!-- translation to 2-character language codes (RFC 5646) is required -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element[@name='iso']/doc:element/doc:field[@name='value']">
				<heal:language>
					<xsl:choose>
						<xsl:when test="text() = 'eng'">en</xsl:when>
						<xsl:when test="text() = 'ell'">el</xsl:when>
						<xsl:when test="text() = 'deu'">de</xsl:when>
						<xsl:when test="text() = 'fra'">fr</xsl:when>
						<xsl:otherwise>other</xsl:otherwise>
					</xsl:choose>
				</heal:language>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='access']/doc:element/doc:field[@name='value']">
				<heal:access>
					<xsl:value-of select="." />
				</heal:access>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='accessText']/doc:element/doc:field[@name='value']">
				<heal:accessText>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:accessText>
			</xsl:for-each>
			
			<!-- dc.rights.uri and dc.rights map to heal.license -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
				<heal:license>
					<xsl:value-of select="." />
				</heal:license>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:field[@name='value']">
				<heal:license>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:license>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='references']/doc:element/doc:field[@name='value']">
				<heal:references>
					<xsl:value-of select="." />
				</heal:references>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreferencedby']/doc:element/doc:field[@name='value']">
				<heal:isReferencedBy>
					<xsl:value-of select="." />
				</heal:isReferencedBy>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element/doc:field[@name='value']">
				<heal:isRelatedTo>
					<xsl:value-of select="." />
				</heal:isRelatedTo>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='mimetype']/doc:element/doc:field[@name='value']">
				<heal:fileFormat>
					<xsl:value-of select="." />
				</heal:fileFormat>
			</xsl:for-each>
			
			<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='recordProvider']/doc:element/doc:field[@name='value']">
				<heal:recordProvider>
					<xsl:if test="../@name != 'none'">
						<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="." />
				</heal:recordProvider>
			</xsl:for-each>
			
			<!-- publishedWorks section -->
			<xsl:choose>
			<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Προπτυχιακή/Διπλωματική εργασία' 
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Μεταπτυχιακή εργασία' 
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Διδακτορική διατριβή'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Δημοσίευση σε συνέδριο'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Δημοσίευση σε περιοδικό'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Κεφάλαιο βιβλίου'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Βιβλίο/Μονογραφία'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Τεχνική αναφορά'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Σύνολο δεδομένων'
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Εκπαιδευτικό υλικό'">
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
					<heal:publicationDate>
						<xsl:value-of select="." />
					</heal:publicationDate>
				</xsl:for-each>
				
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
					<heal:abstract>
						<xsl:if test="../@name != 'none'">
							<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="." />
					</heal:abstract>
				</xsl:for-each>
				
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='tableofcontents']/doc:element/doc:field[@name='value']">
					<heal:tableOfContents>
						<xsl:if test="../@name != 'none'">
							<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="." />
					</heal:tableOfContents>
				</xsl:for-each>
				
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='sponsorship']/doc:element/doc:field[@name='value']">
					<heal:sponsor>
						<xsl:if test="../@name != 'none'">
							<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="." />
					</heal:sponsor>
				</xsl:for-each>
				
				<!-- scholarlyWorks section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Προπτυχιακή/Διπλωματική εργασία' 
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Μεταπτυχιακή εργασία' 
			or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Διδακτορική διατριβή'">
			
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='advisor']/doc:element/doc:field[@name='value']">
						<heal:advisorName>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:advisorName>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='advisorID']/doc:element/doc:element/doc:field[@name='value']">
						<heal:advisorID type="{../../@name}">
						<!--  <heal:advisorID>
							<xsl:attribute name="type"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
							<xsl:value-of select="." />
						</heal:advisorID>
					</xsl:for-each>
					<!-- unqualified advisorID elements map to heal.advisorID.other -->
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='advisorID']/doc:element/doc:field[@name='value']">
						<heal:advisorID type="other">
							<xsl:value-of select="." />
						</heal:advisorID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='committeeMemberName']/doc:element/doc:field[@name='value']">
						<heal:committeeMemberName>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:committeeMemberName>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='committeeMemberID']/doc:element/doc:element/doc:field[@name='value']">
						<heal:committeeMemberID type="{../../@name}">
						<!--  <heal:committeeMemberID>
							<xsl:attribute name="type"><xsl:value-of select="../../@name"/></xsl:attribute>  -->
							<xsl:value-of select="." />
						</heal:committeeMemberID>
					</xsl:for-each>
					<!-- unqualified committeeMemberID elements map to heal.committeeMemberID.other -->
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='committeeMemberID']/doc:element/doc:field[@name='value']">
						<heal:committeeMemberID type="other">
							<xsl:value-of select="." />
						</heal:committeeMemberID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisher']/doc:element/doc:field[@name='value']">
						<heal:academicPublisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:academicPublisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisherID']/doc:element/doc:field[@name='value']">
						<heal:academicPublisherID>
							<xsl:value-of select="." />
						</heal:academicPublisherID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisherDhareID']/doc:element/doc:field[@name='value']">
						<heal:academicPublisherDhareID>
							<xsl:value-of select="." />
						</heal:academicPublisherDhareID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='extent']/doc:element/doc:field[@name='value']">
						<heal:numberOfPages>
							<xsl:value-of select="." />
						</heal:numberOfPages>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='citation']/doc:element/doc:field[@name='value']">
						<heal:bibliographicCitation>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bibliographicCitation>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!--  journal section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Δημοσίευση σε περιοδικό' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
						<heal:publisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:publisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='journalName']/doc:element/doc:field[@name='value']">
						<heal:journalName>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:journalName>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='journalType']/doc:element/doc:field[@name='value']">
						<heal:journalType>
							<xsl:value-of select="." />
						</heal:journalType>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='fullTextAvailability']/doc:element/doc:field[@name='value']">
						<heal:fullTextAvailability>
							<xsl:value-of select="." />
						</heal:fullTextAvailability>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='citation']/doc:element/doc:field[@name='value']">
						<heal:bibliographicCitation>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bibliographicCitation>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!-- conference section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Δημοσίευση σε συνέδριο' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='conferenceName']/doc:element/doc:field[@name='value']">
						<heal:conferenceName>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:conferenceName>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
						<heal:publisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:publisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='fullTextAvailability']/doc:element/doc:field[@name='value']">
						<heal:fullTextAvailability>
							<xsl:value-of select="." />
						</heal:fullTextAvailability>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='citation']/doc:element/doc:field[@name='value']">
						<heal:bibliographicCitation>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bibliographicCitation>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='conferenceItemType']/doc:element/doc:field[@name='value']">
						<heal:conferenceItemType>
							<xsl:value-of select="." />
						</heal:conferenceItemType>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!-- book chapter section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Κεφάλαιο βιβλίου' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='bookName']/doc:element/doc:field[@name='value']">
						<heal:bookName>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bookName>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
						<heal:publisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:publisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='fullTextAvailability']/doc:element/doc:field[@name='value']">
						<heal:fullTextAvailability>
							<xsl:value-of select="." />
						</heal:fullTextAvailability>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='citation']/doc:element/doc:field[@name='value']">
						<heal:bibliographicCitation>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bibliographicCitation>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartof']/doc:element/doc:field[@name='value']">
						<heal:isPartOf>
							<xsl:value-of select="." />
						</heal:isPartOf>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='haspart']/doc:element/doc:field[@name='value']">
						<heal:hasPart>
							<xsl:value-of select="." />
						</heal:hasPart>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='requires']/doc:element/doc:field[@name='value']">
						<heal:requires>
							<xsl:value-of select="." />
						</heal:requires>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='isRequiredBy']/doc:element/doc:field[@name='value']">
						<heal:isRequiredBy>
							<xsl:value-of select="." />
						</heal:isRequiredBy>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!-- book section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Βιβλίο/Μονογραφία' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='bookEdition']/doc:element/doc:field[@name='value']">
						<heal:bookEdition>
							<xsl:value-of select="." />
						</heal:bookEdition>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='extent']/doc:element/doc:field[@name='value']">
						<heal:numberOfPages>
							<xsl:value-of select="." />
						</heal:numberOfPages>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartofseries']/doc:element/doc:field[@name='value']">
						<heal:bookSeries>
							<xsl:value-of select="." />
						</heal:bookSeries>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='citation']/doc:element/doc:field[@name='value']">
						<heal:bibliographicCitation>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:bibliographicCitation>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
						<heal:publisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:publisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='fullTextAvailability']/doc:element/doc:field[@name='value']">
						<heal:fullTextAvailability>
							<xsl:value-of select="." />
						</heal:fullTextAvailability>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='haspart']/doc:element/doc:field[@name='value']">
						<heal:hasPart>
							<xsl:value-of select="." />
						</heal:hasPart>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='requires']/doc:element/doc:field[@name='value']">
						<heal:requires>
							<xsl:value-of select="." />
						</heal:requires>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='isRequiredBy']/doc:element/doc:field[@name='value']">
						<heal:isRequiredBy>
							<xsl:value-of select="." />
						</heal:isRequiredBy>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!-- audiovisual section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Βίντεο'
				or doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Ήχος' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='duration']/doc:element/doc:field[@name='value']">
						<heal:duration>
							<xsl:value-of select="." />
						</heal:duration>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartof']/doc:element/doc:field[@name='value']">
						<heal:isPartOf>
							<xsl:value-of select="." />
						</heal:isPartOf>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='requires']/doc:element/doc:field[@name='value']">
						<heal:requires>
							<xsl:value-of select="." />
						</heal:requires>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='isRequiredBy']/doc:element/doc:field[@name='value']">
						<heal:isRequiredBy>
							<xsl:value-of select="." />
						</heal:isRequiredBy>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='technicalRequirement']/doc:element/doc:field[@name='value']">
						<heal:technicalRequirement>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:technicalRequirement>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='created']/doc:element/doc:field[@name='value']">
						<heal:dateCreated>
							<xsl:value-of select="." />
						</heal:dateCreated>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
				<!-- learningMaterial section -->
				<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']/text() = 'Εκπαιδευτικό υλικό' ">
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='learningResourceType']/doc:element/doc:field[@name='value']">
						<heal:learningResourceType>
							<xsl:value-of select="." />
						</heal:learningResourceType>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisher']/doc:element/doc:field[@name='value']">
						<heal:academicPublisher>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:academicPublisher>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisherID']/doc:element/doc:field[@name='value']">
						<heal:academicPublisherID>
							<xsl:value-of select="." />
						</heal:academicPublisherID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='academicPublisherDhareID']/doc:element/doc:field[@name='value']">
						<heal:academicPublisherDhareID>
							<xsl:value-of select="." />
						</heal:academicPublisherDhareID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='created']/doc:element/doc:field[@name='value']">
						<heal:dateCreated>
							<xsl:value-of select="." />
						</heal:dateCreated>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
						<heal:abstract>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:abstract>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='tableofcontents']/doc:element/doc:field[@name='value']">
						<heal:tableOfContents>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:tableOfContents>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='extent']/doc:element/doc:field[@name='value']">
						<heal:numberOfPages>
							<xsl:value-of select="." />
						</heal:numberOfPages>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='courseDetails']/doc:element/doc:field[@name='value']">
						<heal:courseDetails>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:courseDetails>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='courseID']/doc:element/doc:field[@name='value']">
						<heal:courseID>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:courseID>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartof']/doc:element/doc:field[@name='value']">
						<heal:isPartOf>
							<xsl:value-of select="." />
						</heal:isPartOf>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='haspart']/doc:element/doc:field[@name='value']">
						<heal:hasPart>
							<xsl:value-of select="." />
						</heal:hasPart>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='requires']/doc:element/doc:field[@name='value']">
						<heal:requires>
							<xsl:value-of select="." />
						</heal:requires>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='isRequiredBy']/doc:element/doc:field[@name='value']">
						<heal:isRequiredBy>
							<xsl:value-of select="." />
						</heal:isRequiredBy>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='technicalRequirement']/doc:element/doc:field[@name='value']">
						<heal:technicalRequirement>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:technicalRequirement>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='interactivityLevel']/doc:element/doc:field[@name='value']">
						<heal:interactivityLevel>
							<xsl:value-of select="." />
						</heal:interactivityLevel>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='difficulty']/doc:element/doc:field[@name='value']">
						<heal:difficulty>
							<xsl:value-of select="." />
						</heal:difficulty>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='typicalLearningTime']/doc:element/doc:field[@name='value']">
						<heal:typicalLearningTime>
							<xsl:value-of select="." />
						</heal:typicalLearningTime>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='useDescription']/doc:element/doc:field[@name='value']">
						<heal:useDescription>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:useDescription>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='version']/doc:element/doc:field[@name='value']">
						<heal:version>
							<xsl:if test="../@name != 'none'">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name"/></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</heal:version>
					</xsl:for-each>
					
					<xsl:for-each select="doc:metadata/doc:element[@name='heal']/doc:element[@name='duration']/doc:element/doc:field[@name='value']">
						<heal:duration>
							<xsl:value-of select="." />
						</heal:duration>
					</xsl:for-each>
				</xsl:when>
				</xsl:choose>
				
			</xsl:when>
			</xsl:choose>

		</heal:healMeta>
	</xsl:template>
</xsl:stylesheet>
