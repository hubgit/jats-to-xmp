<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform">
  <output encoding="utf-8" indent="yes"/>

  <param name="now"/>

  <template match="/">
    <variable name="article-meta" select="article/front/article-meta"/>
    <variable name="journal-meta" select="article/front/journal-meta"/>

    <variable name="id" select="$article-meta/article-id[@pub-id-type='publisher-id']/text()"/>
    <variable name="doi" select="$article-meta/article-id[@pub-id-type='doi']/text()"/>
    <variable name="url" select="concat('http://dx.doi.org/', $doi)"/>

    <variable name="authors" select="$article-meta/contrib-group/contrib[@contrib-type='author']/name"/>

    <variable name="license" select="'http://creativecommons.org/licenses/by/3.0/'"/>

    <x:xmpmeta xmlns:x="adobe:ns:meta/">
      <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
        <rdf:Description rdf:about="{$url}"
          xmlns:cc="http://creativecommons.org/ns#"
          xmlns:dc="http://purl.org/dc/elements/1.1/"
          xmlns:prism="http://prismstandard.org/namespaces/basic/2.0/"
          xmlns:rights="http://ns.adobe.com/xap/1.0/rights/"
          xmlns:terms="http://purl.org/dc/terms/"
          xmlns:crossmark="http://crossref.org/crossmark/1.0/"
          xmlns:pdf="http://ns.adobe.com/pdf/1.3/"
          xmlns:pdfx="http://ns.adobe.com/pdfx/1.3/"
          xmlns:xmp="http://ns.adobe.com/xap/1.0/"
          xmlns:foaf="http://xmlns.com/foaf/0.1/"
          xmlns:dctype="http://purl.org/dc/dcmitype/"
          xmlns:bibo="http://purl.org/ontology/bibo/">

          <rdf:type rdf:resource="http://purl.org/ontology/bibo/AcademicArticle"/>

          <comment>Dublin Core: basic, literal properties</comment>
          <dc:format>application/pdf</dc:format>
          <dc:identifier><value-of select="concat('doi:', $doi)"/></dc:identifier>
          <dc:title><value-of select="$article-meta/title-group/article-title"/></dc:title>
          <for-each select="$article-meta/contrib-group/contrib[@contrib-type='author']/name">
            <dc:creator><value-of select="given-names"/><text> </text><value-of select="surname"/></dc:creator>
          </for-each>
          <for-each select="$article-meta/article-categories/subj-group/subject">
            <dc:subject><value-of select="."/></dc:subject>
          </for-each>
          <dc:description><value-of select="concat('doi:', $doi)"/></dc:description><!--TODO-->
          <dc:publisher><value-of select="$journal-meta/publisher/publisher-name"/></dc:publisher>
          <dc:rights>
            <text>Copyright ©&#160;</text>
            <value-of select="$article-meta/permissions/copyright-year"/>
            <text> </text>
            <value-of select="$article-meta/permissions/copyright-holder"/>
          </dc:rights>

          <comment>DCMI Metadata Terms: extra, complex properties</comment>
          <terms:abstract><value-of select="$article-meta/abstract"/></terms:abstract>
          <terms:bibliographicCitation>Vorsino AE, King CB, Haines WP, Rubinoff D (2013) Modeling the Habitat Retreat of the Rediscovered Endemic Hawaiian Moth Omiodes continuatalis Wallengren (Lepidoptera: Crambidae). PLoS ONE 8(1): e51885. doi:10.1371/journal.pone.0051885</terms:bibliographicCitation><!--TODO-->
          <for-each select="$authors">
            <variable name="index" select="position()"/>
            <!--<terms:creator rdf:ID="author-{$index}">-->
            <!-- could make authors into separate objects -->
            <terms:creator>
              <terms:Agent>
                <foaf:familyName><value-of select="surname"/></foaf:familyName>
                <foaf:givenName><value-of select="given-names"/></foaf:givenName><!--foaf:nick?-->
              </terms:Agent>
            </terms:creator>
          </for-each>
          <terms:dateSubmitted><value-of select="$article-meta/history/date[@date-type='submitted']/@iso-8601-date"/></terms:dateSubmitted>
          <terms:dateAccepted><value-of select="$article-meta/history/date[@date-type='accepted']/@iso-8601-date"/></terms:dateAccepted>
          <terms:issued><value-of select="$article-meta/pub-date[@pub-type='epub']/@iso-8601-date"/></terms:issued>
          <terms:format>
            <terms:MediaTypeOrExtent>
              <rdf:value>application/pdf</rdf:value>
            </terms:MediaTypeOrExtent>
          </terms:format>
          <terms:identifier><value-of select="concat('doi:', $doi)"/></terms:identifier>
          <terms:isPartOf rdf:resource="urn:issn:{$journal-meta/issn}"/>
          <terms:license>
            <terms:LicenseDocument rdf:about="$license"/>
          </terms:license>
          <terms:publisher>
            <terms:Agent>
              <foaf:name><value-of select="$journal-meta/publisher/publisher-name"/></foaf:name>
              <foaf:homepage><value-of select="$journal-meta/publisher/publisher-loc/uri"/></foaf:homepage>
            </terms:Agent>
          </terms:publisher>
          <terms:rights>
            <terms:RightsStatement rdf:about="http://creativecommons.org/licenses/by/3.0/legalcode"/><!--TODO-->
          </terms:rights>
          <for-each select="$article-meta/article-categories/subj-group/subject">
            <terms:subject rdf:parseType="Resource">
              <rdf:value><value-of select="."/></rdf:value>
            </terms:subject>
          </for-each>
          <terms:title><value-of select="$article-meta/title-group/article-title"/></terms:title>
          <terms:type rdf:resource="http://purl.org/dc/dcmitype/Text"/>

          <comment>BIBO: extra bibliographic properties</comment>
          <bibo:authorList rdf:parseType="Collection">
            <for-each select="$authors">
              <variable name="index" select="position()"/>
              <!--
              <terms:Agent rdf:about="#author-{$index}">
                <rdf:value><value-of select="given-names"/>&#160;<value-of select="surname"/></rdf:value>
              </terms:Agent>
              -->
              <!-- could make authors into separate objects -->
              <foaf:Agent>
                <foaf:familyName><value-of select="surname"/></foaf:familyName>
                <foaf:givenName><value-of select="given-names"/></foaf:givenName><!--foaf:nick?-->
              </foaf:Agent>
            </for-each>
          </bibo:authorList>
          <bibo:doi><value-of select="$doi"/></bibo:doi>
          <bibo:issn><value-of select="$journal-meta/issn"/></bibo:issn>
          <bibo:issue><value-of select="$article-meta/issue"/></bibo:issue>
          <bibo:uri><value-of select="$url"/></bibo:uri>
          <bibo:volume><value-of select="$article-meta/volume"/></bibo:volume>

          <comment>PDF: keywords</comment>
          <pdf:Keywords>
            <for-each select="$article-meta/article-categories/subj-group[@subj-group-type='keywords']/subject">
              <value-of select="."/>
              <if test="position() != last()">
                <text>, </text>
              </if>
            </for-each>
          </pdf:Keywords>

          <comment>rights: PDF rights</comment>
          <rights:Marked>True</rights:Marked>
          <rights:WebStatement><!--TODO--></rights:WebStatement>
          <rights:UsageTerms>This work is licensed to the public under the Creative Commons Attribution license <value-of select="$license"/></rights:UsageTerms>
          <!--<rights:UsageTerms><value-of select="$article-meta/permissions/copyright-statement"/></rights:UsageTerms>-->

          <comment>license: Creative Commons license</comment>
          <cc:license><value-of select="$license"/></cc:license>
          <cc:attributionURL><value-of select="$url"/></cc:attributionURL>
          <cc:attributionName><value-of select="$article-meta/permissions/copyright-holder"/></cc:attributionName>

          <comment>XMP: metadata dates</comment>
          <xmp:MetadataDate><value-of select="$now"/></xmp:MetadataDate>
          <xmp:CreateDate><value-of select="$now"/></xmp:CreateDate>
          <xmp:ModifyDate><value-of select="$now"/></xmp:ModifyDate>

          <!--
          <comment>PRISM</comment>
          <prism:url><value-of select="$url"/></prism:url>
          <prism:doi><value-of select="$doi"/></prism:doi>
          <prism:issn><value-of select="$journal-meta/issn"/></prism:issn>
          <prism:volume><value-of select="$article-meta/volume"/></prism:volume>
          <prism:issue><value-of select="$article-meta/issue"/></prism:issue>
          <prism:publicationName><value-of select="$journal-meta/journal-title-group/journal-title"/></prism:publicationName>
          <prism:publicationDate><value-of select="$article-meta/pub-date[@pub-type='epub']/@iso-8601-date"/></prism:publicationDate>
          <prism:copyright><value-of select="$article-meta/permissions/copyright-statement"/></prism:copyright>
        -->

          <!--
          <comment>CrossMark</comment>
          <crossmark:MajorVersionDate>2012-10-11</crossmark:MajorVersionDate>
          <crossmark:DOI><value-of select="$doi"/></crossmark:DOI>
          <crossmark:CrossmarkDomainExclusive>false</crossmark:CrossmarkDomainExclusive>
          <crossmark:CrossMarkDomains>
            <rdf:Seq>
              <rdf:li></rdf:li>
            </rdf:Seq>
          </crossmark:CrossMarkDomains>
          <pdfx:CrossmarkMajorVersionDate>2012-10-11</pdfx:CrossmarkMajorVersionDate>
          <pdfx:doi><value-of select="$doi"/></pdfx:doi>
          <pdfx:CrossmarkDomainExclusive>false</pdfx:CrossmarkDomainExclusive>
          <pdfx:CrossMarkDomains>
            <rdf:Seq>
              <rdf:li></rdf:li>
            </rdf:Seq>
          </pdfx:CrossMarkDomains>
          -->
        </rdf:Description>

        <comment>Periodical</comment>
        <rdf:Description rdf:about="urn:issn:{$journal-meta/issn}"
          xmlns:dc="http://purl.org/dc/elements/1.1/"
          xmlns:bibo="http://purl.org/ontology/bibo/">
          <rdf:type rdf:resource="http://purl.org/ontology/bibo/Periodical"/>
          <dc:title><value-of select="$journal-meta/journal-title-group/journal-title"/></dc:title>
          <bibo:uri><value-of select="$journal-meta/publisher/publisher-loc/uri"/></bibo:uri>
        </rdf:Description>
      </rdf:RDF>
    </x:xmpmeta>
  </template>
</stylesheet>