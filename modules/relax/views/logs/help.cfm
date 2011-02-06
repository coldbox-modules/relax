<cfoutput>
<div class="box clear">
	<div class="header">
		<img src="#rc.root#/includes/images/help.png" alt="help" width="30" height="30" />LogBox Integration Help
	</div>
	<div class="body_vertical_nav clearfix">
		<!-- Grey backgound applied to box body -->
		<!-- Vertical nav -->
		<ul class="vertical_nav">
			<li class="active"><a href="##serviceSetup">Service Setup</a></li>
			<li><a href="##relaxLogs">RelaxLogs Setup</a></li>
		</ul>
		<div class="main_column">
			<!-- Content area that wil show the form and stuff -->
			<div class="panes_vertical">
				<!-- All divs inside this div will become panes for navigation above -->
				<div>
					<h1>LogBox Service Configuration</h1>
					<p>In order for our <strong>RelaxLogs</strong> to be able to communicate with your log tables you must enable logging
					in your application.  This is done via <a href="http://wiki.coldbox.org/wiki/LogBox.cfm">LogBox</a> 
					already in your ColdBox applications, you just have to
					add a special Appender (or destination) that will store the log entries in a database.  If you are not 
					building a ColdBox application, which you should :), no worries, <a href="http://wiki.coldbox.org/wiki/LogBox.cfm">LogBox</a>
					 can work with any ColdFusion application or framework.
					This is great because you can keep a historical track of your RESTful service's status and operation.
					So we really recommend you do the following:</p>
					
					<h2>1. LogBox Setup</h2>
					<p>The following is the programmatic approach to adding the 
					<a href="http://wiki.coldbox.org/wiki/LogBox.cfm##DBAppender">LogBox Database Appender</a> so you can log
					entries to the database of your choice.</p>
					
<pre class="brush: coldfusion">
//LogBox DSL
logBox = {
	// Define Appenders
	appenders = {
		// A simple tracer appender
		coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" },
		// Database Appender Registration
		dbAppender = {
			class="coldbox.system.logging.appenders.DBAppender",
			properties = {
				// The datasource to connect to
				dsn = "relax", 
				// The table to log to
				table="api_logs", 
				// If the table does not exist, then create it
				autocreate=true, 
				// The type to use for long text inserting.
				textDBType="longtext"
			}
		}
	},
	// Root Logger
	root = { levelmax="INFO", appenders="coldboxTracer" }
};
</pre>

				<p>
					Once you define the Appender in your configuration, <a href="http://wiki.coldbox.org/wiki/LogBox.cfm">LogBox</a> 
					can send messages to this destination.
					We suggest your review your LogBox skills before anything to understand how Loggers work and how
					you can even declare categories that point to specific destinations.
				</p>
				
				<h2>2. Custom LogBox Category</h2>
				<p>
					We suggest you create a special LogBox category and assign it this Database Appender destination.
					This will provide you with the ability that only log messages with this category will go to your
					database.  We mostly do this to not overpopulate our DB with other kinds of log messages.
				</p>

<pre class="brush: coldfusion">
//LogBox DSL
logBox = {
	// Define Appenders
	appenders = {
		// A simple tracer appender
		coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" },
		// Database Appender Registration
		dbAppender = {
			class="coldbox.system.logging.appenders.DBAppender",
			properties = {
				// The datasource to connect to
				dsn = "relax", 
				// The table to log to
				table="api_logs", 
				// If the table does not exist, then create it
				autocreate=true, 
				// The type to use for long text inserting.
				textDBType="longtext"
			}
		}
	},
	// Root Logger
	root = { levelmax="INFO", appenders="coldboxTracer" },
	
	// Custom LogBox Category
	categories = {
		myRestService = { levelMax="DEBUG", appenders="dbAppender"}
	}
};
</pre>
				
				<h2>3. Logger Injection</h2>
				<p>
					Once this is done, we can inject our logger objects that LogBox provides into our handlers or 
					domain objects that will send messages to our log tables.  This is done via ColdBox's WireBox 
					Dependency Injection engine and our Autowire DSL.  The important part of this section is that
					we inject the logger with the category we setup in our configuration.
				</p>

<pre class="brush: coldfusion">
component name="Awesome REST Handler"{

	// inject correct logger
	property name="logger" inject="logbox:logger:myRestService";
	
	
	// log any call to any event in this awesome REST handler
	function preHandler(event,action){
		if( logger.canDebug() ){
			logger.debug("A request to #event.getCurrentRoutedURL()# was made.", getHTTPRequestData() );
		}
	}

}
</pre>				

				<p>As you can see we first check if we can debug and then send a debug message to LogBox.
					The second argument of any Logger method can be any variable (simple or complex) that we would 
					like to log.  In our case, since it is a RESTful service, we send the request data out
					for logging.  Good for debugging.
				</p>
				
				
				<h2>4. Go Relax!</h2>
				<p>
					You did the hard work, now go relax!
				</p>
				
				</div>
				
				<!--- Relax Logs --->
				<div>
					<h1>RelaxLogs Setup</h1>
					<p>
						Now that you are up and sending log entries to the database from your ColdBox application via
						LogBox, its time to read them.  This is done with 4 little steps.
					</p>
					
					<h2>1. Open the Relax <em>ModuleConfig.cfc</em></h2>
					<p>
						Open this file so we can add our RelaxLogs configuration data. This can be found 
						in the root of the Relax ColdBox module.
					</p>
					
					<h2>2. Locate the <strong>settings</strong></h2>
					<p>
						Locate the <strong>settings</strong> structure, this should contain something like this:
					</p>

<pre class="brush: coldfusion">
// Relax Configuration Settings
	settings = {
		// Relax Version
		version = this.version,
		// History stack size, the number of history items to keep on requests
		maxHistory = 10,
		// logbox integration information needed for log viewer to work
		// this means that it can read tables that are written using the logbox's DB Appender.
		relaxLogs = {
			// THE CF DATASOURCE NAME
			datasource = "relax",
			// THE DB TO USE FOR LOGS, AVAILABLE ADAPTERS ARE: mysql, mssql, postgres
			adapter = "mysql",
			// THE TABLE WHERE THE LOGS ARE
			table 	= "api_logs",
			// PAGING MAX ROWS
			maxRows = 50,
			// PAGING CARROUSEL BANDGAP
			bandGap = 3
		}
	};
</pre>	
				
				<h2>3. Modify the <strong>RelaxLogs</strong> structure</h2>
				<p>
					We can now modify the <strong>RelaxLogs</strong> structure, 
					which tells the RelaxLogs how to read your log entries.  Look at the table
					below to see a description of each entry and possible values.
				</p>
				
				<table class="tablelisting" width="100%">
				<tr>
					<th>Key</th>
					<th>Type</th>
					<th>Description</th>
				</tr>
				<tr>
					<td><strong>datasource</strong></td>
					<td>string</td>
					<td>The datasource to connect to</td>
				</tr>
				<tr>
					<td><strong>adapter</strong></td>
					<td>string</td>
					<td>The db adapter to use to do SQL statements. The available adapters are:
						<ul>
							<li>mysql</li>
							<li>mssql</li>
							<li>postgres</li>
							<li>oracle</li>
						</ul>
						If you would like to contribute more adapters, please send them to
						<a href="mailto:info@coldbox.org">info@coldbox.org</a>
					</td>
				</tr>
				<tr>
					<td><strong>table</strong></td>
					<td>string</td>
					<td>The table that houses your wonderful log entries that you configured in your
					service application via LogBox.
					</td>
				</tr>
				<tr>
					<td><strong>maxRows</strong></td>
					<td>numeric</td>
					<td>The maximum number of rows to display on the grid before we start paging.
					</td>
				</tr>
				<tr>
					<td><strong>bandGap</strong></td>
					<td>numeric</td>
					<td>The bandgap on both left and right of the paging carrousel.
					</td>
				</tr>
			</table>


				<h2>4. Go Relax!</h2>
				<p>You can now relax and go watch your beautiful log entries shine in our Logging console.</p>

				</div>
			</div>
		</div>
	</div>
</div>


<script language="javascript">
$(document).ready(function() {
	// syntax highlight
	SyntaxHighlighter.all();
});
</script>
</cfoutput>