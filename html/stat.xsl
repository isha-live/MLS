<?xml version="1.0" encoding="utf-8" ?>


<!--
   Copyright (C) Roman Arutyunyan
-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
    <html>
        <head>
            <title>bhairavi-sadhana Stats</title>
            <meta http-equiv="refresh" content="10" />
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"></link>
			
<style>
.streamname {
  background-color: #E74C3C; /* Green */
  border: none;
  color: white;
  padding: 5px 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  width : 100%;
}

	.streamname a{
	color: white;
	}
	
	
	.float{
	position:fixed;
	width:60px;
	height:60px;
	bottom:40px;
	right:40px;
	font-size: 16px;
	font-weight: bold;
	line-height: 50px;
	background-color:#ff0000;
	color:#FFF;
	border-radius:10px;
	text-align:center;
	box-shadow: 2px 2px 3px #999;
}

.my-float{
	margin-top:22px;
}
	

			</style>

        </head>
        <body>
			
			<a href="#" class="float">
<i id="totalCount" class="fa fa-plus my-float"></i>
</a>
		<script>
				
				function totalCounts(){
				
			var x = document.querySelectorAll("#liveclients");
			var y = document.getElementById("totalCount");
			
			var i;
			var count = 0;
            for (i = 0; i &lt; x.length; i++) {
                count += parseInt(x[i].innerText);
            }
			
			y.innerText = count;
			
				}
				
	</script>

            <xsl:apply-templates select="rtmp"/>
            <hr/>
            Generated by
            nginx-rtmp-module &#160; <xsl:value-of select="/rtmp/nginx_rtmp_version"/>,
            nginx &#160;<xsl:value-of select="/rtmp/nginx_version"/>,
            pid <xsl:value-of select="/rtmp/pid"/>,
            built <xsl:value-of select="/rtmp/built"/>&#160;<xsl:value-of select="/rtmp/compiler"/>
			
<script>
	totalCounts();
</script>

        </body>
    </html>
</xsl:template>

<xsl:template match="rtmp">
    <table class="table w-auto small rounded" cellspacing="1" cellpadding="2">
		<thead class="thead-dark">
        <tr class="info">
            <th scope="col">RTMP</th>
            <th scope="col">#clients</th>
			<th scope="col">Time</th>
            <th scope="col" colspan="4">Video</th>
            <th scope="col" colspan="4">Audio</th>
            <th scope="col">In bytes</th>
            <th scope="col">Out bytes</th>
            <th scope="col">In bits/s</th>
            <th scope="col">Out bits/s</th>
            <th scope="col">State</th>
            
        </tr>
		</thead>
		
		
        <tr>
            <td colspan="2">Accepted: <xsl:value-of select="naccepted"/></td>
			            <td bgcolor="yellow"><span class="badge badge-danger">
                <xsl:call-template name="showtime">
                    <xsl:with-param name="time" select="/rtmp/uptime * 1000"/>
                </xsl:call-template>
				</span>
            </td>
            <th class="success">codec</th>
            <th class="success">bits/s</th>
            <th class="success">size</th>
            <th class="success">fps</th>
            <th class="success">codec</th>
            <th class="success">bits/s</th>
            <th class="success">freq</th>
            <th class="success">chan</th>
            <td>
                <xsl:call-template name="showsize">
                    <xsl:with-param name="size" select="bytes_in"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="showsize">
                    <xsl:with-param name="size" select="bytes_out"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="showsize">
                    <xsl:with-param name="size" select="bw_in"/>
                    <xsl:with-param name="bits" select="1"/>
                    <xsl:with-param name="persec" select="1"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="showsize">
                    <xsl:with-param name="size" select="bw_out"/>
                    <xsl:with-param name="bits" select="1"/>
                    <xsl:with-param name="persec" select="1"/>
                </xsl:call-template>
            </td>
            <td/>

        </tr>
        <xsl:apply-templates select="server"/>
    </table>
</xsl:template>

<xsl:template match="server">
    <xsl:apply-templates select="application"/>
</xsl:template>

<xsl:template match="application">
    <tr bgcolor="#808B96">
        <td>
            <b><xsl:value-of select="name"/></b>
        </td>
    </tr>
    <xsl:apply-templates select="live"/>
    <xsl:apply-templates select="play"/>
</xsl:template>

<xsl:template match="live">
    <tr bgcolor="#EC7063">
        <td>
            <i>Live Streams</i>
        </td>
        <td class="p-3 mb-2 bg-danger text-white" align="middle">
			<span id="liveclients" class="badge badge-danger"><xsl:value-of select="nclients"/></span>
        </td>
    </tr>
    <xsl:apply-templates select="stream"/>
</xsl:template>

<xsl:template match="play">
    <tr bgcolor="#EC7063">
        <td>
            <i>vod streams</i>
        </td>
        <td class="danger" align="middle">
            <xsl:value-of select="nclients"/>
        </td>
    </tr>
    <xsl:apply-templates select="stream"/>
</xsl:template>

<xsl:template match="stream">
    <tr valign="top">
        <xsl:attribute name="bgcolor">
            <xsl:choose>
                <xsl:when test="active">#F4F6F6</xsl:when>
                <xsl:otherwise>#dddddd</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <td class="streamname">
            <center><a href="">
                <xsl:attribute name="onclick">
                    var d=document.getElementById('<xsl:value-of select="../../name"/>-<xsl:value-of select="name"/>');
                    d.style.display=d.style.display=='none'?'':'none';
                    return false
                </xsl:attribute>
                <xsl:value-of select="name"/>
                <xsl:if test="string-length(name) = 0">
                    [EMPTY]
                </xsl:if>
				</a></center>
        </td>
		
		
        <td class="danger" align="middle"> <xsl:value-of select="nclients"/> </td>
		
		<td bgcolor="yellow"><span class="badge badge-danger">
            <xsl:call-template name="showtime">
               <xsl:with-param name="time" select="time"/>
            </xsl:call-template>
			</span>
        </td>
        <td>
            <xsl:value-of select="meta/video/codec"/>&#160;<xsl:value-of select="meta/video/profile"/>&#160;<xsl:value-of select="meta/video/level"/>
        </td>
        <td class="danger">
            <xsl:call-template name="showsize">
                <xsl:with-param name="size" select="bw_video"/>
                <xsl:with-param name="bits" select="1"/>
                <xsl:with-param name="persec" select="1"/>
            </xsl:call-template>
        </td>
        <td>
            <xsl:apply-templates select="meta/video/width"/>
        </td>
        <td>
            <xsl:value-of select="meta/video/frame_rate"/>
        </td>
        <td>
            <xsl:value-of select="meta/audio/codec"/>&#160;<xsl:value-of select="meta/audio/profile"/>
        </td>
        <td class="danger">
            <xsl:call-template name="showsize">
                <xsl:with-param name="size" select="bw_audio"/>
                <xsl:with-param name="bits" select="1"/>
                <xsl:with-param name="persec" select="1"/>
            </xsl:call-template>
        </td>
        <td>
            <xsl:apply-templates select="meta/audio/sample_rate"/>
        </td>
        <td>
            <xsl:value-of select="meta/audio/channels"/>
        </td>
        <td>
            <xsl:call-template name="showsize">
               <xsl:with-param name="size" select="bytes_in"/>
           </xsl:call-template>
        </td>
        <td>
            <xsl:call-template name="showsize">
                <xsl:with-param name="size" select="bytes_out"/>
            </xsl:call-template>
        </td>
        <td>
            <xsl:call-template name="showsize">
                <xsl:with-param name="size" select="bw_in"/>
                <xsl:with-param name="bits" select="1"/>
                <xsl:with-param name="persec" select="1"/>
            </xsl:call-template>
        </td>
        <td>
            <xsl:call-template name="showsize">
                <xsl:with-param name="size" select="bw_out"/>
                <xsl:with-param name="bits" select="1"/>
                <xsl:with-param name="persec" select="1"/>
            </xsl:call-template>
        </td>
        <td><xsl:call-template name="streamstate"/></td>
        
    </tr>
    <tr style="display:none">
        <xsl:attribute name="id">
            <xsl:value-of select="../../name"/>-<xsl:value-of select="name"/>
        </xsl:attribute>
        <td colspan="16" ngcolor="#eeeeee">
            <table class="table w-auto small rounded" cellspacing="1" cellpadding="2">
                <tr>
                    <th>Id</th>
                    <th>State</th>
                    <th>Address</th>
                    <th>Flash version</th>
                    <th>Page URL</th>
                    <th>SWF URL</th>
                    <th>Dropped</th>
                    <th>Timestamp</th>
                    <th>A-V</th>
                    <th>Time</th>
                </tr>
                <xsl:apply-templates select="client"/>
            </table>
			


			
        </td>
    </tr>
</xsl:template>

<xsl:template name="showtime">
    <xsl:param name="time"/>

    <xsl:if test="$time &gt; 0">
        <xsl:variable name="sec">
            <xsl:value-of select="floor($time div 1000)"/>
        </xsl:variable>

        <xsl:if test="$sec &gt;= 86400">
            <xsl:value-of select="floor($sec div 86400)"/>d
        </xsl:if>

        <xsl:if test="$sec &gt;= 3600">
            <xsl:value-of select="(floor($sec div 3600)) mod 24"/>h
        </xsl:if>

        <xsl:if test="$sec &gt;= 60">
            <xsl:value-of select="(floor($sec div 60)) mod 60"/>m
        </xsl:if>

        <xsl:value-of select="$sec mod 60"/>s
    </xsl:if>
</xsl:template>

<xsl:template name="showsize">
    <xsl:param name="size"/>
    <xsl:param name="bits" select="0" />
    <xsl:param name="persec" select="0" />
    <xsl:variable name="sizen">
        <xsl:value-of select="floor($size div 1024)"/>
    </xsl:variable>
    <xsl:choose>
        <xsl:when test="$sizen &gt;= 1073741824">
            <xsl:value-of select="format-number($sizen div 1073741824,'#.###')"/> T</xsl:when>

        <xsl:when test="$sizen &gt;= 1048576">
            <xsl:value-of select="format-number($sizen div 1048576,'#.###')"/> G</xsl:when>

        <xsl:when test="$sizen &gt;= 1024">
            <xsl:value-of select="format-number($sizen div 1024,'#.##')"/> M</xsl:when>
        <xsl:when test="$sizen &gt;= 0">
            <xsl:value-of select="$sizen"/> K</xsl:when>
    </xsl:choose>
    <xsl:if test="string-length($size) &gt; 0">
        <xsl:choose>
            <xsl:when test="$bits = 1">b</xsl:when>
            <xsl:otherwise>B</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$persec = 1">/s</xsl:if>
    </xsl:if>
</xsl:template>

<xsl:template name="streamstate">
    <xsl:choose>
        <xsl:when test="active">Active</xsl:when>
        <xsl:otherwise>Idle</xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template name="clientstate">
    <xsl:choose>
        <xsl:when test="publishing">Publishing</xsl:when>
        <xsl:otherwise>Playing</xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template match="client">
    <tr>
        <xsl:attribute name="bgcolor">
            <xsl:choose>
                <xsl:when test="publishing">#F4F6F6</xsl:when>
                <xsl:otherwise>#eeeeee</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <td><xsl:value-of select="id"/></td>
        <td><xsl:call-template name="clientstate"/></td>
        <td>
            <a target="_blank">
                <xsl:attribute name="href">
                    http://apps.db.ripe.net/search/query.html&#63;searchtext=<xsl:value-of select="address"/>
                </xsl:attribute>
                <xsl:attribute name="title">whois</xsl:attribute>
                <xsl:value-of select="address"/>
            </a>
        </td>
        <td><xsl:value-of select="flashver"/></td>
        <td>
            <a target="_blank">
                <xsl:attribute name="href">
                    <xsl:value-of select="pageurl"/>
                </xsl:attribute>
                <xsl:value-of select="pageurl"/>
            </a>
        </td>
        <td><xsl:value-of select="swfurl"/></td>
        <td><xsl:value-of select="dropped"/></td>
        <td><xsl:value-of select="timestamp"/></td>
        <td><xsl:value-of select="avsync"/></td>
        <td>
            <xsl:call-template name="showtime">
               <xsl:with-param name="time" select="time"/>
            </xsl:call-template>
        </td>
    </tr>
</xsl:template>

<xsl:template match="publishing">
    publishing
</xsl:template>

<xsl:template match="active">
    active
</xsl:template>

<xsl:template match="width">
    <xsl:value-of select="."/>x<xsl:value-of select="../height"/>
</xsl:template>

</xsl:stylesheet>
