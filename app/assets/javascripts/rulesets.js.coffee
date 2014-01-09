# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ -> 
 $("#status-tooltip").click (e) ->
  modal_html = """
               <div class="modal fade" id="status-tooltip-modal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h3>Overview of Statuses</h3>
                 </div>
                 <div class="modal-body">
                   <p><strong>Active:</strong> Ruleset is active and assigned to a hostname</p>
                   <p><strong>Unassigned:</strong> Ruleset is not assigned to any active hostnames</p>
                   <p><strong>Pending:</strong> Rules were changed and the ruleset can be published <u>if it is assigned to a hostname</u>.  Rulesets only go to pending if their rules are modified and they are assigned to a hostname.</p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Got it !</a>
                 </div>
               </div>
               """               

  $modal_html = $(modal_html)
  $modal_html.modal()


 $("#template-tooltip").click (f) -> 
  modal_html = """
               <div class="modal fade" id="template-tooltip-modal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h3>Creating Ruleset from a Template</h3>
                 </div>
                 <div class="modal-body">
                   If you dont want to start with a blank ruleset, you can start with a ruleset based on a template.  Here at ScaleSimple, we have some system rulesets that you can use to get you going pretty quickly.
                   <p>For example, if you are a Wordpress site, just use our Wordpress template to generate your ruleset and then you can go ahead and make any modifications like TTL length.  The majority of the ruleset will be already generated for you and you are free to make any changes you want !           
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Got it !</a>
                 </div>
               </div>
               """               

  $modal_html = $(modal_html)
  $modal_html.modal()
