<h1>HTTP Response Codes</h1>
<p> All RESTful service APIs should return appropriate <a href="http://en.wikipedia.org/wiki/List_of_HTTP_status_codes">HTTP Status Codes</a> for every request.</p>
<table class="table table-hover table-striped">
  <tbody>
    <tr>
      <th width="30"><strong>Code</strong></th>
      <th><strong>Description</strong></th>
    </tr>
    <tr>
      <td><strong>200</strong></td>
      <td> Success! </td>
    </tr>
    <tr>
      <td><strong>201</strong></td>
      <td> Created. A new   resource has been created successfully.  The response body is either   empty or contains a representation revealing the URI of the newly   created resource. </td>
    </tr>
    <tr>
      <td><strong>202</strong></td>
      <td> Accepted. The request   was valid and accepted but not yet processed.  The response body should   containe a URI to poll for status updates or a token assigned to this   request.  This allows for asynchronous REST requests. </td>
    </tr>
    <tr>
      <td><strong>204</strong></td>
      <td> No content.  The request was successfull but the server has no response for it. </td>
    </tr>
    <tr>
      <td><strong>301</strong></td>
      <td> Moved permanently </td>
    </tr>
    <tr>
      <td><strong>302</strong></td>
      <td> Moved temporarily. The   requested resource resides temporarily under a different URI. Since the   redirection might be altered on occasion, the client SHOULD continue to   use the Request-URI for future requests </td>
    </tr>
    <tr>
      <td><strong>400</strong></td>
      <td> Bad request. Look at the accompanying error messages to see why the request was invalid. </td>
    </tr>
    <tr>
      <td><strong>401</strong></td>
      <td> Unauthorized. Client not authorized to make the request. </td>
    </tr>
    <tr>
      <td><strong>403</strong></td>
      <td> Forbidden.  The   request is understood, but it has been refused.  Look at the   accompanying error messages to see why the request was invalid. </td>
    </tr>
    <tr>
      <td><strong>404</strong></td>
      <td> Not Found </td>
    </tr>
    <tr>
      <td><strong>405</strong></td>
      <td> Method Not Allowed.  The requested method is not allowed for that resource </td>
    </tr>
    <tr>
      <td><strong>406</strong></td>
      <td> Not Acceptable.  Cannot generate representation with given formats, headers or parameters. </td>
    </tr>
    <tr>
      <td><strong>410</strong></td>
      <td> Gone, the resource is no longer available. </td>
    </tr>
    <tr>
      <td><strong>500</strong></td>
      <td> Internal service error. </td>
    </tr>
    <tr>
      <td><strong>503</strong></td>
      <td> Service unavailable. Maybe too many requests. </td>
    </tr>
  </tbody>
</table>