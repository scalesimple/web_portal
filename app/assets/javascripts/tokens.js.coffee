$ -> 

 $("#token-tooltip").click (e) ->
  modal_html = """
               <div class="modal fade" id="status-tooltip-modal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h3>Overview of Token Locations</h3>
                 </div>
                 <div class="modal-body">
                   <p><strong>URL:</strong> Parameters sstoken and ssexpiration must be passed in the URL</p>
                   <p><strong>Cookie:</strong> 2 cookies names must be set, sstoken and ssexpiration</p>
                   <p><strong>Header:</strong> 2 headers must be set, X-SS-Expiration and X-SS-Token</p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Got it !</a>
                 </div>
               </div>
               """               

  $modal_html = $(modal_html)
  $modal_html.modal()

 $("#token_location").change (e) -> 
    if e.currentTarget.value == "header"
      $("#token_url_html").hide()
      $("#token_cookie_html").hide()
      $("#token_header_html").show()
    else if e.currentTarget.value == "url"
      $("#token_cookie_html").hide()
      $("#token_header_html").hide()
      $("#token_url_html").show()
    else if e.currentTarget.value == "cookie"
      $("#token_header_html").hide()
      $("#token_url_html").hide()
      $("#token_cookie_html").show()

