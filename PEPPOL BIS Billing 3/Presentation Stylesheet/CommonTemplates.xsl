<?xml version="1.0" encoding="utf-8"?>
<!--
******************************************************************************************************************

		PEPPOL Instance Documentation	

		title= PEPPOL_BIS 4A/5ACommonTemplates.xml	
		publisher= "SFTI tekniska kansli"
		Creator= SFTI/SL
		created= 2014-02-12
		conformsTo= UBL-Invoice-2.1.xsd
		description= "Common templates for displaying PEPPOL BIS 4A/5A, version 2.0 (Invoice and Credit note)"
		
		Derived from work by OIOUBL, Denmark. For more information, see www.sfti.se or email tekniskt.kansli@skl.se
		
******************************************************************************************************************
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fcn="urn:sfti:se:xsl:functions" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cac cbc ccts sdt udt">
	<xsl:variable name="moduleDoc" select="document('Headlines.xml')"/>
	<xsl:variable name="moduleDocBT" select="document('Headlines-BT.xml')"/>
	<xsl:variable name="UNCL1001" select="document('UNCL1001.xml')"/>
	<xsl:variable name="UNCL4461" select="document('UNCL4461.xml')"/>
	<xsl:variable name="UNCL7161" select="document('UNCL7161.xml')"/>
	<xsl:variable name="UNCL5189" select="document('UNCL5189.xml')"/>
	<xsl:variable name="UNECE" select="document('UNECE.xml')"/>
	<xsl:variable name="lang" select="'se'"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- OSCAR En function som i första hand tar DisplayName och i andra hand Business Termför språk istället för i varje xpath -->
	<xsl:function name="fcn:LabelName">
		<xsl:param name="BT-ID"/>
		<!-- BT inparameter -->
		<xsl:param name="Colon-Suffix"/>
		<!-- true/false om kolon ska läggas till efter business term name-->
		<xsl:variable name="LabelVariable" select="if (exists($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID and @lang=$lang]/DisplayName)) then ($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID and @lang=$lang]/DisplayName) else ($moduleDocBT/SemanticModel/BusinessTerm[@id=$BT-ID and @lang=$lang]/TermName)"/>
		<xsl:value-of select="$LabelVariable"/>
		<xsl:if test="$Colon-Suffix ='true' and $LabelVariable != '' ">:&#160;</xsl:if>
	</xsl:function>
	
	<!--Function to pick the UNCL1001 codes for document header--> 
	<xsl:function name="fcn:DocumentCode">
		<xsl:param name="Code"/>
		<xsl:variable name="DocumentName" select="if (exists($UNCL1001/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$Code and ../../Annotation/Description[@xml:lang=$lang]])) then ($UNCL1001/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$Code]) else ($UNCL1001/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$Code and ../../Annotation/Description[@xml:lang='en']])"/>
		<xsl:value-of select="$DocumentName"/>
	</xsl:function>
	<!--Function to pick the AllowanceReasonCodes--> 
	<xsl:function name="fcn:AllowanceReasonCode">
		<xsl:param name="AllowanceCode"/>
		<xsl:variable name="Allowance" select="if (exists($UNCL5189/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$AllowanceCode and ../../Annotation/Description[@xml:lang=$lang]])) then ($UNCL5189/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$AllowanceCode]) else ($UNCL5189/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$AllowanceCode and ../../Annotation/Description[@xml:lang='en']])"/>
		<xsl:value-of select="$Allowance"/>
	</xsl:function>
	<!--Function to pick the ChargeReasonCodes--> 
	<xsl:function name="fcn:ChargeReasonCode">
		<xsl:param name="ChargeCode"/>
		<xsl:variable name="Charge" select="if (exists($UNCL7161/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$ChargeCode and ../../Annotation/Description[@xml:lang=$lang]])) then ($UNCL7161/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$ChargeCode]) else ($UNCL7161/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$ChargeCode and ../../Annotation/Description[@xml:lang='en']])"/>
		<xsl:value-of select="$Charge"/>
	</xsl:function>
	<!--Function to pick up payment means code-->
	<xsl:function name="fcn:PaymentMeansCode">
		<xsl:param name="PaymentCode"/>
		<xsl:variable name="PaymentMeans" select="if (exists($UNCL4461/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$PaymentCode and ../../Annotation/Description[@xml:lang=$lang]])) then ($UNCL4461/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$PaymentCode]) else ($UNCL4461/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$PaymentCode and ../../Annotation/Description[@xml:lang='en']])"/>
		<xsl:value-of select="$PaymentMeans"/>
	</xsl:function>
	
		<!--Function to pick the UNECE codes--> 
	<xsl:function name="fcn:UNECECode">
		<xsl:param name="UNECECode"/>
		<xsl:variable name="UnitOfMeasureCode" select="if (exists($UNECE/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$UNECECode and ../../Annotation/Description[@xml:lang=$lang]])) then ($UNECE/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$UNECECode]) else ($UNECE/CodeList/SimpleCodeList/Row/Value/SimpleValue[../@ColumnRef='name' and ../../Value[@ColumnRef='code']/SimpleValue=$UNECECode and ../../Annotation/Description[@xml:lang='en']])"/>
		<xsl:value-of select="$UnitOfMeasureCode"/>
	</xsl:function>
	
	<xsl:template name="replace">
    <xsl:param name="string"/>
    <xsl:choose>
        <xsl:when test="contains($string,'&#10;')">
            <xsl:value-of select="substring-before($string,'&#10;')"/>
            <br/>
            <xsl:call-template name="replace">
                <xsl:with-param name="string" select="substring-after($string,'&#10;')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="cbc:Note">
    <xsl:call-template name="replace">
        <xsl:with-param name="string" select="."/>
    </xsl:call-template>
</xsl:template>
	
	<!--Party templates from here:-->
	<xsl:template match=" cac:AccountingSupplierParty">
		<xsl:call-template name="SellerParty"/>
	</xsl:template>
	<xsl:template match=" cac:AccountingCustomerParty">
		<xsl:call-template name="BuyerParty"/>
	</xsl:template>
	<!--SELLER PARTY STARTS HERE-->
	<xsl:template name="SellerParty">
		<xsl:value-of select="fcn:LabelName('BT-27', 'true')"/>
		<b>
		<xsl:choose>
			<xsl:when test="cac:Party/cac:PartyName !=''">
		<xsl:apply-templates select="cac:Party/cac:PartyName"/>
		</xsl:when>
		<xsl:otherwise>
				<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
		</xsl:otherwise>
		</xsl:choose>
		</b>
		<br/><b><xsl:value-of select="fcn:LabelName('BG-5', 'false')"/></b>
		<xsl:call-template name="SellerPostalAddress"/>
		
		<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID">
			<br/>
			<small>
				<xsl:value-of select="fcn:LabelName('BT-29', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID"/>
				<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID"/>]

					</xsl:if>
			</small>
		</xsl:if>
		<!--Party legal registration: -->
		<xsl:if test="cac:Party/cac:PartyLegalEntity">
			<xsl:if test="cac:Party/cac:PartyLegalEntity">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-30', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-27', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress !=''">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-33', 'true')"/>
					<xsl:choose>
						<xsl:when test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !='' and 

							cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
							<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName"/>,&#160;

							<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName !=''">
								<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cbc:CityName"/>
							</xsl:if>
							<xsl:if test="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country !=''">
								<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:Party/cac:PartyTaxScheme">
			<small>
				<xsl:if test="cac:Party/cac:PartyTaxScheme">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-31', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</xsl:if>
				<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason">
					<br/>
					<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ExemptionReason']"/-->
					<!--xsl:value-of select="$moduleDocBT/SemanticModel/BusinessTerm[@id='BT-29' and @lang='en']/TermName"/-->

					&#160;<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason"/>
				</xsl:if>
			</small>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerPartyName">
		<xsl:if test="cac:Party/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerPostalAddress">
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:value-of select="fcn:LabelName('BT-35', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-36', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:Party/cac:PostalAddress/cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
						<xsl:value-of select="fcn:LabelName('BT-38', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:PostalZone"/>,
						<br/>
						<xsl:value-of select="fcn:LabelName('BT-37', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="fcn:LabelName('BT-37', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:Party/cac:PostalAddress/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:Party/cac:PostalAddress/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-39', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>,<br/>
					<xsl:value-of select="fcn:LabelName('BT-40', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-39', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Party/cac:PostalAddress/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-40', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SellerContact">
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ID">
			<small>
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ID"/>
			</small>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name !=''">
			<br/>
			<xsl:value-of select="fcn:LabelName('BT-41', 'true')"/>
			<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name"/>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone !=''">
			<br/>
			<span class="UBLTelephone">
				<xsl:value-of select="fcn:LabelName('BT-42', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax !=''">
			<br/>
			<span class="UBLTelefax">
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
			<br/>
			<span class="UBLElectronicMail">
				<xsl:value-of select="fcn:LabelName('BT-43', 'true')"/>
				<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
			</span>
		</xsl:if>
	</xsl:template>
	<!--BUYER PARTY STARTS HERE-->
	<xsl:template name="BuyerParty">
		<xsl:value-of select="fcn:LabelName('BT-44', 'true')"/>
		<xsl:apply-templates select="cac:Party/cac:PartyName"/>
		<br/><b><xsl:value-of select="fcn:LabelName('BG-8', 'false')"/></b>
		<xsl:call-template name="BuyerPostalAddress"/>
		
		<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID">
			<br/>
			<small>
				<b><xsl:value-of select="fcn:LabelName('BT-46', 'true')"/></b>
				<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID"/>
				<xsl:if test="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyIdentification/cbc:ID/@schemeID"/>]

					</xsl:if>
					<br/>
					
			</small>
		</xsl:if>
		<!--Party legal registration: -->
		<xsl:if test="cac:Party/cac:PartyLegalEntity">
			<xsl:if test="cac:Party/cac:PartyLegalEntity">
				<small>
					<xsl:value-of select="fcn:LabelName('BT-47', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</small>
			</xsl:if>
			<xsl:if test="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName !=''">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-44', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:Party/cac:PartyTaxScheme">
			<small>
				<xsl:if test="cac:Party/cac:PartyTaxScheme">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-48', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
					<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</xsl:if>
				<xsl:if test="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason">
					<br/>
					<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ExemptionReason']"/-->
					<!--xsl:value-of select="$moduleDocBT/SemanticModel/BusinessTerm[@id='BT-29' and @lang='en']/TermName"/-->

					&#160;<xsl:apply-templates select="cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason"/>
				</xsl:if>
			</small>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerPartyName">
		<xsl:if test="cac:Party/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerPostalAddress">
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:value-of select="fcn:LabelName('BT-50', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:value-of select="fcn:LabelName('BT-51', 'true')"/>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:PostalZone !='' or cac:Party/cac:PostalAddress/cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PostalAddress/cbc:PostalZone !=''">
						<xsl:value-of select="fcn:LabelName('BT-53', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:PostalZone"/> &#160;
						<xsl:value-of select="fcn:LabelName('BT-52', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="fcn:LabelName('BT-52', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' or cac:Party/cac:PostalAddress/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !='' and cac:Party/cac:PostalAddress/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-54', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>,
							<xsl:value-of select="fcn:LabelName('BT-55', 'true')"/>
					<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Party/cac:PostalAddress/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-54', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Party/cac:PostalAddress/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-55', 'true')"/>
						<xsl:apply-templates select="cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/><br/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BuyerContact">
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID">
			<small>
				<xsl:value-of select="fcn:LabelName('BT-10', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID"/>
				<br/>
			</small>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name !=''">
			<xsl:value-of select="fcn:LabelName('BT-56', 'true')"/>
			<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name"/>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone !=''">
			<span class="UBLTelephone">
				<xsl:value-of select="fcn:LabelName('BT-57', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
			<span class="UBLTelefax">
				<xsl:value-of select="fcn:LabelName('BT-22', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail !=''">
			<span class="UBLElectronicMail">
				<xsl:value-of select="fcn:LabelName('BT-58', 'true')"/>
				<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cac:InvoiceLine/cbc:AccountingCost !=''">
									
										<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
									
									<xsl:value-of select="cac:InvoiceLine/cbc:AccountingCost"/>
								</xsl:if>
			<xsl:if test="cac:CreditNoteLine/cbc:AccountingCost !=''">
									
										<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
									
									<xsl:value-of select="cac:CreditNoteLine/cbc:AccountingCost"/>
								</xsl:if>
	</xsl:template>
	<!-- PAYEE PARTY STARTS HERE-->
	<xsl:template name="PayeeParty">
		<xsl:value-of select="fcn:LabelName('BT-59', 'true')"/>
		<xsl:apply-templates select="cac:PayeeParty/cac:PartyName"/>
		<xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID">
			<br/>
			<small>
				<xsl:value-of select="fcn:LabelName('BT-60', 'true')"/>
				<xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID"/>
				<xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID/@schemeID"/>]

					</xsl:if>
			</small>
		</xsl:if>
		<!--Party legal registration: -->
		<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
			<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity">
				<br/>
				<small>
					<xsl:value-of select="fcn:LabelName('BT-61', 'true')"/>
					<xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID"/>
					<xsl:if test="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</small>
			</xsl:if>
		</xsl:if>
		<!--Party VAT registration: -->
		<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
			<small>
				<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-63', 'true')"/>
					<xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID"/>
					<xsl:if test="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID !='' ">

						&#160;[<xsl:apply-templates select="cac:PayeeParty/cac:PartyTaxScheme/cbc:CompanyID/@schemeID"/>]

					</xsl:if>
				</xsl:if>
			</small>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PayeePartyName">
		<xsl:if test="cac:PayeeParty/cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:PartyName">
		<xsl:if test="cbc:Name !=''">
			<xsl:apply-templates select="cbc:Name"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:PostalAddress | cac:DeliveryAddress | cac:Address ">
		<xsl:if test="cbc:StreetName !=''">
			<br/>
			<span class="UBLStreetName">
				<xsl:apply-templates select="cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cbc:AdditionalStreetName !=''">
			<br/>
			<span class="UBLAdditionalStreetName">
				<xsl:apply-templates select="cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cbc:PostalZone !='' or cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cbc:PostalZone !=''">
						<xsl:apply-templates select="cbc:PostalZone"/>
						<xsl:apply-templates select="cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cbc:CountrySubentity !='' or cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cbc:CountrySubentity !='' and cac:Country !=''">
					<br/>
					<xsl:apply-templates select="cbc:CountrySubentity"/>,
							<xsl:apply-templates select="cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cbc:CountrySubentity !=''">
						<xsl:apply-templates select="cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Country !=''">
						<xsl:apply-templates select="cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:Country">
		<span>
			<xsl:apply-templates select="cbc:IdentificationCode"/>
			<!-- Checking of listID (normally NOT a function of a stylesheet): -->
			<xsl:if test="cbc:IdentificationCode/@listID !=''">
				<xsl:if test="cbc:IdentificationCode/@listID !='ISO3166-1:Alpha2'">

					&#160;<small>
						<em>[<xsl:apply-templates select="cbc:IdentificationCode/@listID"/>
					&#160;-invalid listID]</em>
					</small>
				</xsl:if>
			</xsl:if>
		</span>
	</xsl:template>
	<!--Delivery templates start: -->
	<xsl:template match="cac:Delivery" mode="DocumentHeader">
		<p>
			<xsl:if test="cac:DeliveryLocation !=''">
				<b>
					<xsl:value-of select="fcn:LabelName('BG-13', 'false')"/>
					<br/>
				</b>
				<xsl:apply-templates select="cac:DeliveryLocation"/>
			</xsl:if>
		</p>
	</xsl:template>
	<xsl:template match="cac:DeliveryLocation">
		<xsl:if test="cbc:ID !=''">
			<xsl:value-of select="fcn:LabelName('BT-71', 'true')"/>
			<xsl:apply-templates select="cbc:ID"/>
			<xsl:choose>
				<xsl:when test="cbc:ID/@schemeID !=''">
							&#160;[<xsl:apply-templates select="cbc:ID/@schemeID"/>]
						</xsl:when>
				<xsl:otherwise>
							&#160;[No schemeID]
						</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="cac:Address !=''">
		<br/>
			<xsl:call-template name="DeliveryAddress"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="DeliveryAddress">
	<b><xsl:value-of select="fcn:LabelName('BG-15', 'false')"/></b>
		<xsl:if test="cac:Address/cbc:StreetName !=''">
			<span class="UBLStreetName">
				<br/><xsl:value-of select="fcn:LabelName('BT-75', 'true')"/>
				<xsl:apply-templates select="cac:Address/cbc:StreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:AdditionalStreetName !=''">
			<span class="UBLAdditionalStreetName">
				<br/><xsl:value-of select="fcn:LabelName('BT-76', 'true')"/>
				<xsl:apply-templates select="cac:Address/cbc:AdditionalStreetName"/>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:PostalZone !='' or cac:Address/cbc:CityName !=''">
			<br/>
			<span class="UBLCityName">
				<xsl:choose>
					<xsl:when test="cac:Address/cbc:PostalZone !=''">
						<xsl:value-of select="fcn:LabelName('BT-78', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:PostalZone"/>&#160;
						<xsl:value-of select="fcn:LabelName('BT-77', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CityName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="fcn:LabelName('BT-77', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CityName"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="cac:Address/cbc:CountrySubentity !='' or cac:Address/cac:Country !=''">
			<xsl:choose>
				<xsl:when test="cac:Address/cbc:CountrySubentity !='' and cac:Address/cac:Country !=''">
					<br/>
					<xsl:value-of select="fcn:LabelName('BT-79', 'true')"/>
					<xsl:apply-templates select="cac:Address/cbc:CountrySubentity"/>,
							
							<xsl:value-of select="fcn:LabelName('BT-80', 'true')"/>
					<xsl:apply-templates select="cac:Address/cac:Country"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<xsl:if test="cac:Address/cbc:CountrySubentity !=''">
						<xsl:value-of select="fcn:LabelName('BT-79', 'true')"/>
						<xsl:apply-templates select="cac:Address/cbc:CountrySubentity"/>
					</xsl:if>
					<xsl:if test="cac:Address/cac:Country !=''">
						<xsl:value-of select="fcn:LabelName('BT-80', 'true')"/>
						<xsl:apply-templates select="cac:Address/cac:Country/cbc:IdentificationCode"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--Contact from here: -->
	<xsl:template match="cac:AccountingSupplierParty/cac:Party" mode="accsupcontact">
		<xsl:apply-templates select="cac:Contact"/>
	</xsl:template>
	<xsl:template match="cac:AccountingCustomerParty/cac:Party" mode="acccuscontact">
		<xsl:apply-templates select="cac:Contact"/>
	</xsl:template>
	<!--Invoiceline start: -->
	<xsl:template match="cac:InvoiceLine | cac:CreditNoteLine">
		<tr>
			<td>
				<xsl:apply-templates select="cbc:ID"/>
			</td>
			<td>
				<xsl:apply-templates select="cac:Item/cac:SellersItemIdentification"/>
			</td>
			<td>
				<xsl:apply-templates select="cac:Item/cbc:Name"/>
				<br/><br/>
				<small>
					<xsl:if test="cac:Item/cac:StandardItemIdentification/cbc:ID !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-157', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID"/>
						<xsl:choose>
							<xsl:when test="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID !=''">
								<small>&#160;[<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID"/>]</small>
							</xsl:when>
							<xsl:otherwise>
								<small>&#160;[No schemeID]</small>
							</xsl:otherwise>
						</xsl:choose>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cbc:Description !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-154', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cbc:Description"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:AdditionalItemProperty !=''">
						<xsl:apply-templates select="cac:Item/cac:AdditionalItemProperty"/>
					</xsl:if>
					<xsl:if test="cbc:Note !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-127', 'true')"/>
						</b>
						<xsl:apply-templates select="cbc:Note"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:CommodityClassification !=''">
						<xsl:apply-templates select="cac:Item/cac:CommodityClassification"/>
					</xsl:if>
					<xsl:if test="cbc:AccountingCost !=''">
						<b>
						<xsl:value-of select="fcn:LabelName('BT-19', 'true')"/>
							<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccountingCost']"/-->&#160;</b>:
					<xsl:apply-templates select="cbc:AccountingCost"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:InvoicePeriod !=''">
						<b>
							<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='InvoicePeriod']"/-->
							<xsl:value-of select="fcn:LabelName('BG-14', 'true')"/>
						</b>&#160;
					<xsl:apply-templates select="cac:InvoicePeriod"/>
						<br/>
					</xsl:if>
					<xsl:if test="cac:Price/cac:AllowanceCharge !=''">
						<xsl:apply-templates select="cac:Price/cac:AllowanceCharge" mode="PriceUnit-new"/>
					</xsl:if>
					<xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-159', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode"/>
						<xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID !=''">
							<small>&#160;[<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID"/>]</small>
						</xsl:if>
						<br/>
					</xsl:if>
					<xsl:if test="cac:OrderLineReference/cbc:LineID !=''">
						<b>
							<xsl:value-of select="fcn:LabelName('BT-132', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:OrderLineReference/cbc:LineID"/>
						<br/>
					</xsl:if>
				</small>
			</td>
			<td align="left">
				<xsl:if test="cbc:InvoicedQuantity !=''">
					<xsl:apply-templates select="cbc:InvoicedQuantity"/>&#160;
					<xsl:value-of select="fcn:UNECECode(cbc:InvoicedQuantity/@unitCode)"/>&#160;&#160;
				</xsl:if>
				<xsl:if test="cbc:CreditedQuantity !=''">&#160;
					<xsl:apply-templates select="cbc:CreditedQuantity"/>
					<xsl:value-of select="fcn:UNECECode(cbc:CreditedQuantity/@unitCode)"/>&#160;&#160;
				</xsl:if>
				&#160;&#160;
			</td>
		
			<td>
				<xsl:apply-templates select="cac:Price"/>
				<xsl:if test="cac:Price/cbc:BaseQuantity">
					<small>
						<br/>
						<b>
							<xsl:value-of select="fcn:LabelName('BT-149', 'true')"/>
						</b>
						<xsl:apply-templates select="cac:Price/cbc:BaseQuantity"/>
					</small>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="cac:Item/cac:ClassifiedTaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">

							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID"/>,&#160;

							
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;
							<xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="cac:TaxTotal/cbc:TaxAmount">
					<small>
						<xsl:choose>
							<xsl:when test="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent !=''">
								<br/>(<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount"/>)

						</xsl:when>
							<xsl:otherwise>
							(<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount"/>)

						</xsl:otherwise>
						</xsl:choose>
					</small>
				</xsl:if>
			</td>
			<td>
				<xsl:if test="cac:AllowanceCharge !=''">
					<xsl:apply-templates select="cac:AllowanceCharge" mode="LineLevel-new"/>
				</xsl:if>
			</td>
			<td align="right">
				<xsl:apply-templates select="cbc:LineExtensionAmount"/>
			</td>
		</tr>
		<!-- Invoice line/part 3: -->
		<xsl:if test="cac:Delivery !=''">
			<tr>
				<td>
				</td>
				<td>
				</td>
				<td class="UBLName">
					<table border="0" width="90%" cellspacing="0" cellpadding="2">
						<xsl:apply-templates select="cac:Delivery" mode="line-new"/>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:CommodityClassification">
		<xsl:if test="cbc:CommodityCode !=''">
			<b>
				<xsl:value-of select="fcn:LabelName('BT-158', 'true')"/>
			</b>
			<xsl:apply-templates select="cbc:CommodityCode"/>
			<xsl:choose>
				<xsl:when test="cbc:CommodityCode/@listID !=''">
					<small>&#160;[<xsl:apply-templates select="cbc:CommodityCode/@listID"/>]</small>
				</xsl:when>
				<xsl:otherwise>
					<small>&#160;[No listID]</small>
				</xsl:otherwise>
			</xsl:choose>
			<br/>
		</xsl:if>
		<xsl:if test="cbc:ItemClassificationCode !=''">
			<b>
				<xsl:value-of select="fcn:LabelName('BT-158', 'true')"/>
			</b>
			<xsl:apply-templates select="cbc:ItemClassificationCode"/>
			<xsl:choose>
				<xsl:when test="cbc:ItemClassificationCode/@listID !=''">
					<small>&#160;[<xsl:apply-templates select="cbc:ItemClassificationCode/@listID"/>]</small>
				</xsl:when>
				<xsl:otherwise>
					<small>&#160;[No listID]</small>
				</xsl:otherwise>
			</xsl:choose>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:AdditionalItemProperty">
		<b>
			<xsl:value-of select="fcn:LabelName('BT-160', 'true')"/>
		</b>
		<xsl:apply-templates select="cbc:Name"/> = 
		<xsl:apply-templates select="cbc:Value"/>
		<br/>
	</xsl:template>
	<xsl:template match="cac:SellersItemIdentification">
		<xsl:apply-templates select="cbc:ID"/>
	</xsl:template>
	<xsl:template match="cac:Price">
		<xsl:apply-templates select="cbc:PriceAmount"/>&#160;<xsl:apply-templates select="cbc:PriceAmount/@currencyID"/>
	</xsl:template>
	<!--Invoiceline end-->
	<!-- Document legal totals from here-->
	<!-- Document legal totals until here-->
	<!--Allowance/Charge from here-->
	<!-- 1) A/C on document level -->
	<xsl:template match="cac:AllowanceCharge" mode="DocumentLevel-new">
		<tr>
		
			<td valign="top" colspan="2">
			
				<xsl:choose>
					<xsl:when test="cbc:ChargeIndicator ='true'">
						<xsl:value-of select="fcn:LabelName('BG-21', 'true')"/>
					</xsl:when>
					<xsl:when test="cbc:ChargeIndicator ='false'">
						<xsl:value-of select="fcn:LabelName('BG-20', 'true')"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cbc:AllowanceChargeReasonCode !=''">
					<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
				</xsl:if>
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="cbc:Amount"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="Allowance">
		<tr>
			<td valign="top" colspan="2">
				
					<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
					<!--xsl:value-of select="fcn:AllowanceReasonCode(cbc:AllowanceChargeReasonCode)"/-->
				
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="cbc:Amount"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="Charge">
						
			<tr>
			<td valign="top" colspan="2">
			<xsl:apply-templates select="cbc:AllowanceChargeReasonCode"/>
			</td>
			<td valign="top" colspan="2">
				<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			</td>
			<td>
				<xsl:if test="cac:TaxCategory !='' ">
					<xsl:choose>
						<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>,
							&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%

						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>:&#160;

							<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td valign="top" align="right">
				<xsl:apply-templates select="cbc:Amount"/>
			</td>
		</tr>
	</xsl:template>
	
	<!-- 2) A/C on line level -->
	<xsl:template match="cac:AllowanceCharge" mode="LineLevel-new">
		<xsl:apply-templates select="cbc:Amount"/>
		<small>
			<br/>
			<xsl:apply-templates select="cbc:AllowanceChargeReason"/>
			<br/>
		</small>
	</xsl:template>
	<!-- 3) A/C on price unit level (for information only) -->
	<xsl:template match="cac:AllowanceCharge" mode="PriceUnit-new">
	<b>
		<xsl:choose>
			<xsl:when test="cbc:ChargeIndicator ='true'">
			<xsl:value-of select="fcn:LabelName('BT-147', 'true')"/>
				<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ChargeIndicatorTrue']"/-->
			</xsl:when>
			<xsl:when test="cbc:ChargeIndicator ='false'">
			<xsl:value-of select="fcn:LabelName('BT-147', 'true')"/>
				<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ChargeIndicatorFalse']"/-->
			</xsl:when>
		</xsl:choose>
		</b>
		<xsl:choose>
			<xsl:when test="cbc:BaseAmount !='' ">
				&#160;<xsl:apply-templates select="cbc:Amount"/>
				<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='BasedOnAmount']"/-->
				<br/><b><xsl:value-of select="fcn:LabelName('BT-148', 'true')"/></b>

				&#160;<xsl:apply-templates select="cbc:BaseAmount"/>
			</xsl:when>
			<xsl:otherwise>
				&#160;<xsl:apply-templates select="cbc:Amount"/>
			</xsl:otherwise>
		</xsl:choose>
		<br/>
	</xsl:template>
	<!-- AllowanceCharge end -->
	<!-- Tax (VAT) totals from here: -->
	<xsl:template match="cac:TaxTotal/cac:TaxSubtotal">
		<tr class="TAXInformation">
			<td colspan="2">
				<xsl:apply-templates select="cac:TaxCategory/cac:TaxScheme/cbc:ID"/>
				:&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:ID"/>&#160;
				<small>(=
			 	<xsl:choose>
						<!-- List as included in the BII/BIS subset: -->
						<xsl:when test="cac:TaxCategory/cbc:ID = 'S'">
							<xsl:value-of select="'Standard rate'"/>
						</xsl:when>
						<xsl:when test="cac:TaxCategory/cbc:ID = 'E'">
							<xsl:value-of select="'Exempt from tax'"/>
						</xsl:when>
						<xsl:when test="cac:TaxCategory/cbc:ID = 'AE'">
							<em>
								<strong>
									<xsl:value-of select="'Reverse Charge'"/>
								</strong>
							</em>
						</xsl:when>
						<xsl:when test="cac:TaxCategory/cbc:ID = 'AA'">
							<xsl:value-of select="'Lower rate'"/>
						</xsl:when>
						<xsl:when test="cac:TaxCategory/cbc:ID = 'H'">
							<xsl:value-of select="'Higher rate'"/>
						</xsl:when>
						<xsl:when test="cac:TaxCategory/cbc:ID = 'Z'">
							<xsl:value-of select="'Zero rate'"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- Outside the BII subset: -->
							<xsl:value-of select="'Not specified'"/>
						</xsl:otherwise>
					</xsl:choose>

				),</small>
				<xsl:choose>
					<xsl:when test="cac:TaxCategory/cbc:Percent !=''">
						&#160;<xsl:apply-templates select="cac:TaxCategory/cbc:Percent"/>%
					</xsl:when>
					<xsl:otherwise>
						%
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td colspan="2">
				<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReason !=''">
					<xsl:apply-templates select="cac:TaxCategory/cbc:TaxExemptionReason"/>
				</xsl:if>
			</td>
			<td colspan="2">
				<xsl:apply-templates select="cbc:TaxableAmount"/>
			</td>
			<td align="right">
				<xsl:apply-templates select="cbc:TaxAmount"/>
			</td>
		</tr>
	</xsl:template>
	<!--TaxTotal until here-->
	<!--PaymentMeans from here-->
	
	<xsl:template name="cac:PaymentMeans">
		<tr>
			<td valign="top">
					<xsl:value-of select="fcn:PaymentMeansCode(cbc:PaymentMeansCode)"/>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					<xsl:apply-templates select="cac:CardAccount/cbc:PrimaryAccountNumberID"/>&#160;
					<xsl:if test="cac:CardAccount/cbc:HolderName !=''">
					<small>(<xsl:apply-templates select="cac:CardAccount/cbc:HolderName"/>)</small>
					</xsl:if>
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cbc:ID !='' or 
							cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID !=''">
					<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					</xsl:if>
					<xsl:apply-templates select="cac:PayeeFinancialAccount/cbc:ID"/>&#160;
						<xsl:if test="cac:PayeeFinancialAccount/cbc:Name">
						<small>(<xsl:apply-templates select="cac:PayeeFinancialAccount/cbc:Name"/>)</small>
					</xsl:if>
				</xsl:if>
				<xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
				<xsl:apply-templates select="cac:PaymentMandate/cbc:ID"/>
				
				</xsl:if>
			</td>
			<td valign="top" colspan="2">
				<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
					<xsl:apply-templates select="cac:CardAccount/cbc:NetworkID"/>
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
					<xsl:if test="cac:CardAccount/cbc:PrimaryAccountNumberID !='' or cac:CardAccount/cbc:NetworkID !=''">
						<br/>
					</xsl:if>
					<xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>&#160;
				</xsl:if>
				<xsl:if test="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID !='' ">
						<xsl:apply-templates select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>&#160;
					</xsl:if>
					<xsl:if test="cac:PaymentMandate/cbc:ID !='' or cac:PaymentMandate/cac:PayerFinancialAccount !=''">
				<xsl:apply-templates select="cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID"/>
				
				</xsl:if>
			</td>
			<td valign="top" align="right">
				<xsl:if test="cbc:PaymentID !=''">
					<xsl:apply-templates select="cbc:PaymentID"/>
				</xsl:if>
			</td>
			<!--td valign="top" align="right">
				<xsl:if test="cbc:PaymentDueDate !=''">
					<xsl:apply-templates select="cbc:PaymentDueDate"/>
				</xsl:if>
			</td-->
		</tr>
	</xsl:template>
	<!--PaymentMeans template until here-->
	<!-- PaymentTerms from here: -->
	<xsl:template match="cac:PaymentTerms">
		<xsl:if test="cbc:Note !=''">
					<br/>
					<xsl:apply-templates select="cbc:Note"/>
					
		
		</xsl:if>
	</xsl:template>
	<!-- Document references from here: -->
	<xsl:template match="cac:AdditionalDocumentReference ">
	
	<xsl:if test="cbc:ID !=''">
			
				<xsl:value-of select="fcn:LabelName('BT-122', 'true')"/><xsl:apply-templates select="cbc:ID"/>
	</xsl:if>
	<small>
	<xsl:if test="cbc:DocumentType !='' or cbc:DocumentTypeCode !=''">
			<br/>
			-&#160;<xsl:value-of select="fcn:LabelName('BT-123', 'true')"/><xsl:apply-templates select="cbc:DocumentType"/>&#160;<xsl:apply-templates select="cbc:DocumentTypeCode"/>
				
		</xsl:if>
		<br/>
			<xsl:apply-templates select="cac:Attachment"/>
		</small>
	</xsl:template>
	<xsl:template match="cac:Attachment">
		<!-- No processing of attached document, just info: -->
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@mimeCode !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-1', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@mimeCode"/>
				<br/>
		</xsl:if>
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@format !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-1', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@format"/>
				<br/>
		</xsl:if>
		<xsl:if test="cbc:EmbeddedDocumentBinaryObject/@filename !=''">
				-&#160;<xsl:value-of select="fcn:LabelName('BT-125-2', 'true')"/><xsl:apply-templates select="cbc:EmbeddedDocumentBinaryObject/@filename"/>
				<br/>
		</xsl:if>
		<xsl:if test="cac:ExternalReference !=''">
			-&#160;<xsl:apply-templates select="cac:ExternalReference"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:ExternalReference">
		<xsl:if test="cbc:URI !=''">
			<xsl:value-of select="fcn:LabelName('BT-124', 'true')"/>
			<xsl:apply-templates select="cbc:URI"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cac:BillingReference">
		<br/>
		<xsl:if test="cac:CreditNoteDocumentReference !=''">
					<xsl:apply-templates select="cac:CreditNoteDocumentReference/cbc:ID"/>&#160;
				</xsl:if>
		<xsl:if test="cac:InvoiceDocumentReference !=''">
			<xsl:if test="cac:CreditNoteDocumentReference !=''">
				<br/>
			</xsl:if>
					<xsl:apply-templates select="cac:InvoiceDocumentReference/cbc:ID"/>&#160;
				</xsl:if>
	</xsl:template>
	<!-- Document references end -->
	<!--Periods from here-->
	<xsl:template match="cac:InvoicePeriod">
		<xsl:if test="cbc:StartDate !=''">
			<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PeriodStartDate']"/-->&#160;
			<xsl:apply-templates select="cbc:StartDate"/>&#160;
		</xsl:if>
		<xsl:if test="cbc:EndDate !='' ">
			<!--xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PeriodEndDate']"/-->
			&#160;<xsl:apply-templates select="cbc:EndDate"/>&#160;
		</xsl:if>
	</xsl:template>
	<!--Periods end-->
</xsl:stylesheet>
