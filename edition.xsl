<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/edition">
		<xsl:text>&#xa;</xsl:text>
		<edition xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/">
			<edition_title><xsl:value-of select="edition_title"/></edition_title>
			<xsl:text>&#xa;</xsl:text>
			<categories>
			<xsl:for-each select="categories/category">
				<category>
					<xsl:attribute name="name">
						<xsl:value-of select="category_name"/>
					</xsl:attribute>
					<Table aid:table="table" aid:trows="1" aid:tcols="1">
						<Cell aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="250">
							<xsl:copy-of select="category_name" />
						</Cell>
					</Table>
					<books>
						<xsl:for-each select="books/book">
							<book>
								<Table aid:table="table" aid:trows="1" aid:tcols="2">
									<Cell aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="75">
										<xsl:copy-of select="cover_image/image" /><xsl:text>&#xa;</xsl:text>
										<binding_types>
											<xsl:if test="binding_types/binding_type[text()='Baðbók']">
												<image alt="Baðbók" href="file:///assets/bað.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
											<xsl:if test="binding_types/binding_type[text()='Innbundin']">
												<image alt="Innbundin" href="file:///assets/ib.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
									 		<xsl:if test="binding_types/binding_type[text()='Sveigjanleg kápa']">
												<image alt="Sveigjanleg kápa" href="file:///assets/svk.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
									 		<xsl:if test="binding_types/binding_type[text()='Kilja']">
												<image alt="Kilja" href="file:///assets/kil.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
											 <xsl:if test="binding_types/binding_type[text()='Gormabók']">
											 <image alt="Kilja" href="file:///assets/gor.ai"/><xsl:text> </xsl:text>
										  	</xsl:if>
									 		<xsl:if test="binding_types/binding_type[text()='Harðspjaldabók fyrir 0-2 ára']">
												<image alt="Harðspjaldabók" href="file:///assets/hsp.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
									 		<xsl:if test="binding_types/binding_type[text()='Rafbók']">
												<image alt="Rafbók" href="file:///assets/raf.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
									 		<xsl:if test="binding_types/binding_type[text()='Hljóðbók']">
												<image alt="Hljóðbók" href="file:///assets/hlb.ai"/><xsl:text> </xsl:text>
									 		</xsl:if>
									 	</binding_types>
									</Cell>
									 <Cell aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="175">
									 	<xsl:if test="pre_title!=''">
									 		<xsl:copy-of select="pre_title"></xsl:copy-of><xsl:text>&#xa;</xsl:text>
										</xsl:if>
										<xsl:copy-of select="title"></xsl:copy-of><xsl:text>&#xa;</xsl:text>
										<xsl:if test="post_title!=''">
											<xsl:copy-of select="post_title"></xsl:copy-of><xsl:text>&#xa;</xsl:text>
										</xsl:if>
										<authors>
											<xsl:for-each select="authors/author_group">
												<xsl:if test="author_type!='Höfundur' and author_type!='Höfundar'">
													<xsl:choose>
														<xsl:when test="author_type='Myndhöfundur' or author_type='Myndhöfundar'">
															<author_type><xsl:text>Myndh: </xsl:text></author_type>
														</xsl:when>
														<xsl:when test="author_type='Þýðandi' or author_type='Þýðendur'">
															<author_type><xsl:text>Þýð: </xsl:text></author_type>
														</xsl:when>
														<xsl:when test="author_type='Endursögn'">
															<author_type><xsl:text>Endurs: </xsl:text></author_type>
														</xsl:when>
														<xsl:when test="author_type='Skrásetning' or author_type='Þýðendur'">
															<author_type><xsl:text>Skrás: </xsl:text></author_type>
														</xsl:when>
														<xsl:when test="author_type='Umsjón'">
															<author_type><xsl:text>Umsj: </xsl:text></author_type>
														</xsl:when>
														<xsl:when test="author_type='Myndaritstjórn'">
															<author_type><xsl:text>Myndaritstj: </xsl:text></author_type>
														</xsl:when>
														<xsl:otherwise>
															<author_type><xsl:value-of select="author_type"/><xsl:text>: </xsl:text></author_type>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												<author_name><xsl:value-of select="author_names"/></author_name>
												<xsl:text>&#xa;</xsl:text>
											</xsl:for-each>
										</authors>
									 	<xsl:copy-of select="description/description_firstline" /><xsl:text>&#xa;</xsl:text>
										<xsl:for-each select="description/description_more">
											<xsl:copy-of select="."></xsl:copy-of><xsl:text>&#xa;</xsl:text>
										</xsl:for-each>
										<xsl:if test="page_count or hours">
											<book_length>
												<xsl:if test="page_count">
													<xsl:value-of select="page_count"></xsl:value-of>
													<xsl:text> bls.</xsl:text>
												</xsl:if>
												<xsl:if test="page_count and hours">
													<xsl:text> / </xsl:text>
												</xsl:if>
												<xsl:if test=" hours">
													<xsl:text> klst.</xsl:text>
												</xsl:if>
											</book_length><xsl:text>&#xa;</xsl:text>
										</xsl:if>
									 	<xsl:copy-of select="publisher/publisher_name" />
									 </Cell>
								</Table>
							</book><xsl:text>&#xa;</xsl:text>
						</xsl:for-each>
					</books>
				</category>
			</xsl:for-each>
			</categories>
		</edition>
	</xsl:template>
</xsl:stylesheet>