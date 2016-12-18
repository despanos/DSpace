<?xml version="1.0" encoding="UTF-8"?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
    
	Developed by DSpace @ Lyncode <dspace@lyncode.com> 
	Following Driver Guidelines 2.0:
		- http://www.driver-support.eu/managers.html#guidelines

 -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:doc="http://www.lyncode.com/xoai">
	<!--  modified by dspanos -->
	<xsl:output indent="yes" method="xml" omit-xml-declaration="yes" encoding="UTF-8"/>
	<!-- end dspanos -->

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
 
 	<!-- Formatting dc.date.issued -->
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field/text()">
		<xsl:call-template name="formatdate">
			<xsl:with-param name="datestr" select="." />
		</xsl:call-template>
	</xsl:template>
	
	<!-- Removing other dc.date.* -->
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name!='issued']" />

	<!-- Prefixing dc.type -->
	<!-- modified by dspanos -->
	<!--  <xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field/text()">
		<xsl:call-template name="addPrefix">
			<xsl:with-param name="value" select="." />
			<xsl:with-param name="prefix" select="'info:eu-repo/semantics/'"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>   -->
	<!-- end dspanos -->
	
	<!-- Prefixing and Modifying dc.rights -->
	<!-- Removing unwanted -->
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:element" />
	<!-- Replacing -->
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:field/text()">
		<xsl:text>info:eu-repo/semantics/openAccess</xsl:text>
	</xsl:template>
	
	<!-- modified by dspanos -->
	<!--  <xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field/text()">
		<xsl:choose>
			<xsl:when test="text() = 'Δημοσίευση σε περιοδικό'">
				<xsl:text>info:eu-repo/semantics/article</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Προπτυχιακή/Διπλωματική εργασία'">
				<xsl:text>info:eu-repo/semantics/bachelorThesis</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Μεταπτυχιακή εργασία'">
				<xsl:text>info:eu-repo/semantics/masterThesis</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Διδακτορική διατριβή'">
				<xsl:text>info:eu-repo/semantics/doctoralThesis</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Βιβλίο/Μονογραφία'">
				<xsl:text>info:eu-repo/semantics/book</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Κεφάλαιο βιβλίου'">
				<xsl:text>info:eu-repo/semantics/bookPart</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Δημοσίευση σε συνέδριο'">
				<xsl:text>info:eu-repo/semantics/conferenceObject</xsl:text>
			</xsl:when>
			<xsl:when test="text() = 'Τεχνική αναφορά'">
				<xsl:text>info:eu-repo/semantics/report</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>info:eu-repo/semantics/other</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[text() = 'Δημοσίευση σε περιοδικό']/text()">
		<xsl:text>info:eu-repo/semantics/article</xsl:text>
	</xsl:template>  -->
	<xsl:template match="/doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field/text()">
		<xsl:call-template name="replacetype">
			<xsl:with-param name="typestr" select="." />
		</xsl:call-template>
	</xsl:template>
	<!--  end dspanos -->

	<!-- AUXILIARY TEMPLATES -->
	
	<!-- dc.type prefixing -->
	<xsl:template name="addPrefix">
		<xsl:param name="value" />
		<xsl:param name="prefix" />
		<xsl:choose>
			<xsl:when test="starts-with($value, $prefix)">
				<xsl:value-of select="$value" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($prefix, $value)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Date format -->
	<xsl:template name="formatdate">
		<xsl:param name="datestr" />
		<xsl:variable name="sub">
			<xsl:value-of select="substring($datestr,1,10)" />
		</xsl:variable>
		<xsl:value-of select="$sub" />
	</xsl:template>
	
	<!-- modified by dspanos -->
	<xsl:template name="replacetype">
		<xsl:param name="typestr" />
		<xsl:choose>
			<xsl:when test="$typestr = 'Δημοσίευση σε περιοδικό'">
				<xsl:value-of select="'info:eu-repo/semantics/article'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Προπτυχιακή/Διπλωματική εργασία'">
				<xsl:value-of select="'info:eu-repo/semantics/bachelorThesis'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Μεταπτυχιακή εργασία'">
				<xsl:value-of select="'info:eu-repo/semantics/masterThesis'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Διδακτορική διατριβή'">
				<xsl:value-of select="'info:eu-repo/semantics/doctoralThesis'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Βιβλίο/Μονογραφία'">
				<xsl:value-of select="'info:eu-repo/semantics/book'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Κεφάλαιο βιβλίου'">
				<xsl:value-of select="'info:eu-repo/semantics/bookPart'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Δημοσίευση σε συνέδριο'">
				<xsl:value-of select="'info:eu-repo/semantics/conferenceObject'" />
			</xsl:when>
			<xsl:when test="$typestr = 'Τεχνική αναφορά'">
				<xsl:value-of select="'info:eu-repo/semantics/report'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'info:eu-repo/semantics/other'" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- end dspanos -->
</xsl:stylesheet>
