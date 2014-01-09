$(function () {

	var rules = {
		    	rules: {
					rule_name: {
						minlength: 2,
						required: true
					}
				}
		    };
		
	 
	$('.sorted-table').sortable({
	  containerSelector: 'tbody',
	  itemSelector: 'tr',
	  handle: 'i.icon-move',
	  placeholder: '<tr class="placeholder"/>',
	  serialize: function ($parent, $children, parentIsContainer) {

            var result = $.extend({}, $parent.data())

            if(parentIsContainer)
                return $children
            else if ($children[0]) 
                result.children = $children
            delete result.sortable
            delete result.subContainer

            return result;
        },
	  onDrop: function (item, container, _super) {
            var dataToSend = $(".sorted-table").sortable("serialize").get();
            var ruleset_id = $('#ordered-rulesets').attr('data-ruleset-id');
            var payload = new Object; 
            payload["order"] = new Object 

            for(i = 0; i< dataToSend.length; i++) {
            	payload["order"][i] = dataToSend[i].id;
            }

            $.ajax({
                url: "/rulesets/" + ruleset_id + "/reorder",
                type: "post",
                data: payload,
                cache: false,
                dataType: "json",
                success: function () {	 

				        $.bootstrapGrowl("Rules successfully reordered !", {
				            type: 'success',
				            align: 'center',
				            offset: {from: 'top', amount: 50}, 
				            width: 500,
						    allow_dismiss: true
				        });
                },
                error: function () {	 

				        $.bootstrapGrowl("Rules successfully reordered !", {
				            type: 'success',
				            align: 'center',
				            offset: {from: 'top', amount: 50}, 
				            width: 500,
						    allow_dismiss: true
				        });
				}
             });
           
            _super(item,container);
    }
	});
		
});