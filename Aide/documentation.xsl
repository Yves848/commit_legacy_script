<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html"
    encoding="UTF-8"
    version="4.0"    indent="yes"/>
  <xsl:template match="/documentation">
    <html>
      <head>
        <title><xsl:value-of select="description/@nom"/></title>        <link href="documentation.css" rel="stylesheet" type="text/css"/>      </head>      <body>        <xsl:apply-templates/>
      </body>    </html>
  </xsl:template>  <xsl:template match="description">    <br/>    <table id="stl_titre">      <tr><td><xsl:value-of select="@nom"/></td></tr>    </table>    <br/><br/>      <span id="stl_description">Système(s) d'exploitation(s) : </span><xsl:value-of select="@os"/>      <br/>      <span id="stl_description">Type de reprise : </span>      <xsl:choose>        <xsl:when test="@type = 'fichiers'">          <xsl:text>Lecture binaire des fichiers</xsl:text>        </xsl:when>        <xsl:when test="@type = 'sql'">          <xsl:text>Accès direct/ODBC à la base de donneés</xsl:text>        </xsl:when>      </xsl:choose>  </xsl:template>  <xsl:template match="systemes">    <xsl:call-template name="tpl_titre_section">      <xsl:with-param name="alibelle">Système(s) rencontré(s)</xsl:with-param>    </xsl:call-template>    <ol>      <xsl:apply-templates/>    </ol>  </xsl:template>  <xsl:template match="systeme">    <li>      <p><xsl:value-of select="designation"/></p>      <p><div id="stl_rubrique">Méthode(s) de récupération physique de fichier(s) :</div></p>      <ol>     			<xsl:call-template name = "tpl_liste_techniques_recuperation_fichiers"/>      </ol>      <p><div id="stl_rubrique">Fichier(s) à récupérer :</div></p>      <table id="stl_liste">        <xsl:call-template name = "tpl_liste_fichiers"/>      </table>    </li>  </xsl:template>  <xsl:template name="tpl_titre_section">    <xsl:param name="alibelle" select="Section"/>    <br/>    <p>      <table id="stl_titre_section">        <tr><td><xsl:value-of select="$alibelle"/></td></tr>      </table>    </p>  </xsl:template>  <xsl:template name="tpl_liste_techniques_recuperation_fichiers">    <xsl:for-each select = "recuperations/recuperation">      <li>        <xsl:apply-templates select="@description"/>        <br/><br/>
        <xsl:if test="etape">
          <ul>          
            <xsl:for-each select="etape">
              <li><xsl:value-of select="@value"/></li>
            </xsl:for-each>
          </ul>
          <br/>
        </xsl:if>
        <xsl:if test="@remarques">
          <div id="stl_remarque">Remarque : <xsl:value-of select="@remarques"/></div>
          <br/>
        </xsl:if>              </li>    </xsl:for-each>  </xsl:template>
  <xsl:template name="tpl_liste_fichiers">    <tr>      <th>Nom du fichier</th>      <th>Répertoire</th>      <th>Description</th>    </tr>    <xsl:for-each select="fichiers/fichier">      <tr>        <td id="stl_ligne_liste_fichiers"><xsl:apply-templates select="@nom"/></td>        <td id="stl_ligne_liste_fichiers"><xsl:apply-templates select="@repertoire"/></td>        <td id="stl_ligne_liste_fichiers">          <xsl:choose>            <xsl:when test="@description">              <xsl:apply-templates select="@description"/>            </xsl:when>            <xsl:otherwise>              <xsl:text disable-output-escaping="yes">&#160;</xsl:text>            </xsl:otherwise>          </xsl:choose>        </td>      </tr>			 </xsl:for-each>  </xsl:template>  <xsl:template match="/documentation/perimetres">    <xsl:call-template name="tpl_titre_section">      <xsl:with-param name="alibelle">Périmètre de la reprise</xsl:with-param>    </xsl:call-template>    <table id="stl_liste">      <th>Donnée</th>      <th>Commentaire</th>      <th>Donneés rejetées (non-traitées)</th>
      <xsl:apply-templates/>    </table>  </xsl:template>  <xsl:template match="donnee">    <tr>      <td id="stl_ligne_liste_donnees"><xsl:value-of select="@designation"/></td>      <td id="stl_ligne_liste_donnees">        <xsl:choose>          <xsl:when test="@commentaire">            <xsl:apply-templates select="@commentaire"/>          </xsl:when>          <xsl:otherwise>            <xsl:text disable-output-escaping="yes">&#160;</xsl:text>          </xsl:otherwise>        </xsl:choose>      </td>      <td id="stl_ligne_liste_donnees">
        <xsl:choose>
          <xsl:when test="@rejets">
            <xsl:apply-templates select="@rejets"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text disable-output-escaping="yes">&#160;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>  </xsl:template>  <xsl:template match="observations">    <xsl:call-template name="tpl_titre_section">      <xsl:with-param name="alibelle">Observation(s)</xsl:with-param>    </xsl:call-template>    <ol>      <xsl:apply-templates/>    </ol>  </xsl:template>  <xsl:template match="observation">    <li>      <div id="stl_remarque"><xsl:value-of select="@texte"/></div>      
      <br/>
      <table>          
        <xsl:for-each select="images/image">
          <tr>
            <td>
              <xsl:element name="img">
                <xsl:attribute name="src">
                  <xsl:text>images/</xsl:text><xsl:value-of select="@nom"/>
                </xsl:attribute>
              </xsl:element>
            </td>
            <td width="3%"></td>
            <td id="stl_ligne_legende">
              <xsl:value-of select="@legende"/>        
            </td>
          </tr>            
        </xsl:for-each>
      </table>
      <br/>
      <xsl:if test="@lien != ''">
        <br/>
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:value-of select="@lien"/>
          </xsl:attribute>
          <xsl:value-of select="@texte_lien"/>
        </xsl:element>
        <br/>
      </xsl:if>      <br/>
    </li>  </xsl:template>
  <xsl:template match="liens">
    <xsl:call-template name="tpl_titre_section">
      <xsl:with-param name="alibelle">Lien(s) utile(s)</xsl:with-param>
    </xsl:call-template>
    <ol>
      <xsl:for-each select="lien">
        <li>
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="url"/>
            </xsl:attribute>
            <xsl:value-of select="@titre"/>
          </xsl:element>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template></xsl:stylesheet>
