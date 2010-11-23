<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--=========Users Box=========-->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/users_icon.png" alt="History" width="24" height="24" />LogBox Viewer
		</div>
		<div class="body">
			<p>Log Viewer Details:</p>
			
			<p class="center">
			<a href="#event.buildLink(rc.xehPurge)#" class="button confirmIt" 
			   data-message="Do you really want to purge all the monitor logs?">
				<span>
					<img src="#rc.root#/includes/images/database_refresh.png" border="0" align="absmiddle" alt="purge logs" />
					Purge Logs
				</span>
			</a>
			</p>
		</div>
	</div>
	<!--End Users Box-->	
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header">
			<img src="#rc.root#/includes/images/tables_icon.png" alt="Accordion" width="30" height="30" />
			DB Log Viewer
		</div>
		
		<div class="body">
		<p>This is the contents of the log table you configured Relax with.  You can page through it
		and also do dynamic filtering of the current viewable window.</p>
		
		<!--- MessageBox --->
		#getPlugin("messagebox").renderit()#	
		
		<!--- Filter Bar --->
		<div id="logFilterBar" style="margin-bottom:15px">
			<div>
				<fieldset>
					<!--- Log Filter --->
					<label for="logFilter" class="inline">Log Filter: </label>
					<input size="60" type="text" name="logFilter" id="logFilter" value="" />
					
					<!--- Image Filters --->
					<img src="#rc.root#/includes/images/fatal.png"		alt="fatal" 	title="fatal" id="filter_fatal"	onClick="filter('fatal')" /> 
					<img src="#rc.root#/includes/images/error.gif" 		alt="error" 	title="error" id="filter_error"	onClick="filter('error')" />
					<img src="#rc.root#/includes/images/warning.png" 		alt="warning" 	title="warning" id="filter_warn"	onClick="filter('warn')" />
					<img src="#rc.root#/includes/images/information.png" 	alt="info" 		title="info" id="filter_info"	onClick="filter('info')" />
					<img src="#rc.root#/includes/images/debug.gif" 		alt="debug" 	title="debug" id="filter_debug"	onClick="filter('debug')" />
					<img src="#rc.root#/includes/images/arrow_refresh_small.png" 	alt="reset filter" title="reset filter"	onClick="filter('')" />
				</fieldset>
			</div>
		</div>
		
		<!--- Paging --->
		#rc.pagingPlugin.renderit(rc.totalLogCount,rc.pagingLink)#
		
		<!--- Logs Table --->
		<table class="tablesorter" id="logsTable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead>
				<tr>
					<th class="center" width="50">Type</th>
					<th class="center" width="115">Logdate</th>
					<th class="{sorter: false}">Message</th>
					<th class="tableActions center{sorter: false}">Actions</th>
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
					<td class="tableActions"><a href="javascript:quickViewer('#rc.qlogs.id#')" title="quick viewer"><img src="#rc.root#/includes/images/info.png" alt="view" border="0"></a></td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		
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
		#rc.pagingPlugin.renderit(rc.totalLogCount,rc.pagingLink)#
	</div>
</div>


<script language="javascript">
$(document).ready(function() {
	// global setups
	$logsTable 			= $("##logsTable");
	$logFilterBar 		= $("##logFilterBar");
	$logsRecordcount 	= $("##logsRecordcount");
	
	// setup sorting and filtering
	$logsTable.tablesorter();
	$("##logFilter").keyup(function(){
		$.uiTableFilter( $logsTable, this.value, "Message" );
	})
	// current type filter
	curFilter = '';
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