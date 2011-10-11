<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--=========Settings Box=========-->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/settings.png" alt="History" width="24" height="24" />RelaxLogs Settings
		</div>
		<div class="body">
			<p>The following are the settings the RelaxLogs are configured with:</p>
			<table class="tablelisting" width="100%">
				<tr>
					<th width="55" class="textRight">Datasource:</th>
					<td>#rc.logSettings.datasource#</td>
				</tr>
				<tr>
					<th  class="textRight">Adapter:</th>
					<td>#rc.logSettings.adapter#</td>
				</tr>
				<tr>
					<th  class="textRight">Table:</th>
					<td>#rc.logSettings.table#</td>
				</tr>
				<tr>
					<th  class="textRight">Max Rows:</th>
					<td>#rc.maxRows#</td>
				</tr>
			</table>			
			
			<!--- Purge Commands --->
			<p class="center">
			<a href="#event.buildLink(rc.xehPurge)#" class="button confirmIt" 
			   title="Purge the entire log database"
			   data-message="Do you really want to purge all the monitor logs?">
				<span>
					<img src="#rc.root#/includes/images/database_refresh.png" border="0" align="absmiddle" alt="purge logs" />
					Purge Logs
				</span>
			</a>
			</p>
		</div>
	</div>
	
	<!--- Severity Showdown --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/line_chart.png" alt="Help" width="24" height="24" />Severity Showdown!
		</div>
		<div class="body">
			<p>
			Checkout your Log Severity Showdown
			</p>
			<cfchart format="png" 
					 show3d="true" 
					 chartwidth="240">
				<cfchartseries type="bar" colorlist="##B22222,##FF69B4,##FF8C00, ##1E90FF,##ADFF2F"   >
					<cfchartdata item="fatal"  value="#rc.qStats.fatalCount#">
					<cfchartdata item="error"  value="#rc.qStats.errorCount#">
					<cfchartdata item="warn"  value="#rc.qStats.warnCount#">
					<cfchartdata item="info"  value="#rc.qStats.infoCount#">
					<cfchartdata item="debug"  value="#rc.qStats.debugCount#">
				</cfchartseries>
			</cfchart>
		</div>
	</div>	
	
	<!--=========Settings Box=========-->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/help.png" alt="Help" width="24" height="24" />RelaxLogs Setup
		</div>
		<div class="body">
			<p>
			To learn more how to configure Relax to read your LogBox logs then visit our help section.
			</p>
			
			<p class="center">
			<a href="#event.buildLink(rc.xehLogHelp)#" class="button" 
			   title="Visit our LogBox Help section">
				<span>
					<img src="#rc.root#/includes/images/help_small.png" border="0" align="absmiddle" alt="help" />
					Help
				</span>
			</a>
			
			
		</div>
	</div>	
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header">
			<img src="#rc.root#/includes/images/database.png" alt="Database" width="30" height="30" />
			RelaxLogs
		</div>
		
		<div class="body">
		<p>This is the contents of the log table you configured Relax with.  You can page through it, search and also do dynamic filtering of the current viewable window.</p>
		
		<!--- MessageBox --->
		#getPlugin("messagebox").renderit()#
		
		<!--- Filter Bar --->
		<div id="logFilterBar" style="margin-bottom:15px">
			<div>
				#html.startForm(action="relax/logs")#
				<fieldset>
					<!--- Log Filter --->
					<label for="search" class="inline">Log Search: </label>
					<input size="60" type="text" class="textfield" name="search" id="search" value="#rc.search#" />
					#html.submitButton(value="Search")#
					#html.href(href=event.buildLink(rc.xehLogViewer), text=html.button(value="Clear"))#
				</fieldset>
				#html.endForm()#
			</div>
		</div>	
		
		<!--- Filter Bar --->
		<div id="logFilterBar" style="margin-bottom:15px">
			<div>
				<form>
				<fieldset>
					<!--- Log Filter --->
					<label for="logFilter" class="inline">Log Filter: </label>
					<input size="60" type="text" class="textfield" name="logFilter" id="logFilter" value="" />
					
					<!--- Image Filters --->
					<img src="#rc.root#/includes/images/fatal.png"		alt="fatal" 	title="fatal filter" id="filter_fatal"	onClick="filter('fatal')" /> 
					<img src="#rc.root#/includes/images/error.gif" 		alt="error" 	title="error filter" id="filter_error"	onClick="filter('error')" />
					<img src="#rc.root#/includes/images/warning.png" 		alt="warning" 	title="warning filter" id="filter_warn"	onClick="filter('warn')" />
					<img src="#rc.root#/includes/images/information.png" 	alt="info" 		title="info filter" id="filter_info"	onClick="filter('info')" />
					<img src="#rc.root#/includes/images/debug.gif" 		alt="debug" 	title="debug filter" id="filter_debug"	onClick="filter('debug')" />
					<img src="#rc.root#/includes/images/arrow_refresh_small.png" 	alt="reset filter" title="reset filter"	onClick="filter('')" />
				</fieldset>
				</form>
			</div>
		</div>
		
		<!--- Show DropDown --->
		<div class="floatRight" style="margin-top:10px">
			<em>Max Records</em>
			<select name="maxRows" id="maxRows" title="Choose how many records to display per window">
				<option <cfif rc.maxRows eq 25>selected="selected"</cfif>>25</option>
				<option <cfif rc.maxRows eq 50>selected="selected"</cfif>>50</option>
				<option <cfif rc.maxRows eq 100>selected="selected"</cfif>>100</option>
				<option <cfif rc.maxRows eq 200>selected="selected"</cfif>>200</option>
			</select>
		</div>
		
		<!--- Paging --->
		#rc.pagingPlugin.renderit(rc.totalLogCount,rc.pagingLink,rc.maxRows)#
		
		<!--- Logs Table --->
		<table class="tablesorter" id="logsTable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead>
				<tr>
					<th class="center" width="50">Type</th>
					<th class="center" width="115">Logdate</th>
					<th class="{sorter: false}">Message</th>
					<th class="center {sorter: false}">Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="rc.qLogs">
				<tr>
					<td class="center">
						<img src="#rc.root#/includes/images/#severityLookup(rc.qLogs.severity)#" title="#rc.qLogs.severity#" alt="#rc.qLogs.severity#" />
						<span class="hidden">#rc.qLogs.severity#</span> 
					</td>
					<td class="center">#dateformat(rc.qLogs.logdate,"short")# #timeFormat(rc.qLogs.logDate,"medium")#</td>
					<td>#left(rc.qLogs.Message,95)#<cfif len(rc.qLogs.message) gt 95>...</cfif></td>
					<td class="center"><a href="javascript:quickViewer('#rc.qlogs.id#')" title="quick log entry viewer"><img src="#rc.root#/includes/images/info.png" alt="view" border="0"></a></td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		
		<!--- No Records Found --->
		<cfif rc.qLogs.recordcount eq 0>
			#getPlugin("MessageBox").renderMessage("warning","No Log Records Found!")#
		</cfif>
		
		<!--- Legend --->
		<div id="legend" class="floatRight">
			<strong>Legend:</strong> 
			<img src="#rc.root#/includes/images/fatal.png" alt="fatal" /> Fatal
			<img src="#rc.root#/includes/images/error.gif" alt="error" /> Error
			<img src="#rc.root#/includes/images/warning.png" alt="warn" /> Warn
			<img src="#rc.root#/includes/images/information.png" alt="info" /> Info
			<img src="#rc.root#/includes/images/debug.gif" alt="debug" /> Debug
		</div>
		
		<!--- Paging --->
		#rc.pagingPlugin.renderit(rc.totalLogCount,rc.pagingLink,rc.maxRows)#
		
		<br/><br/>
		
	</div>
</div>


<script language="javascript">
$(document).ready(function() {
	// global setups
	$logsTable 			= $("##logsTable");
	$logFilterBar 		= $("##logFilterBar");
	$logsRecordcount 	= $("##logsRecordcount");
	
	// syntax highlight
	SyntaxHighlighter.all();
	
	// setup sorting and filtering
	$logsTable.tablesorter();
	$("##logFilter").keyup(function(){
		$.uiTableFilter( $logsTable, this.value, "Message" );
	})
	// current type filter
	curFilter = '';
	// show records
	$("##maxRows").change(function(e){
		window.location = '#event.buildLink(rc.xehStoreMaxRows)#/maxRows/'+this.value;
	});
});
function filter(incomingFilter){
	// if the same filter, then toggle to reset.
	if( curFilter == incomingFilter ){ incomingFilter = '' }
	// Turn previous filter off
	$("##filter_"+curFilter).css("border","none");
	// save the incoming filter
	curFilter = incomingFilter;
	// turn filter on
	if( curFilter.length ){
		$("##filter_"+curFilter).css("border","1px solid red");
	}
	$.uiTableFilter( $logsTable, incomingFilter, "Type" );
}
function quickViewer(logID){
	var params = {logID:logID}
	openRemoteModal("#event.BuildLink(rc.xehQuickView)#",params);
}
</script>
</cfoutput>