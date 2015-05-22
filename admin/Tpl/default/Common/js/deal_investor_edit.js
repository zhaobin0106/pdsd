function total_price(class_name){
    var total_income=0;
    var total_out=0;
	 
     $(class_name).each(function(i){
        var item_income=0;
        var item_out=0;
         $(this).find(".income_table .amount").each(function(){
             $(this).val(formatMoney( $(this).val(),0));
            if($(this).val()!=''){
                 item_income=item_income+parseInt($(this).val());
            }
        });
        $(this).find(".out_table_1 .amount").each(function(){
             $(this).val(formatMoney( $(this).val(),0));
            if($(this).val()!=''){
                item_out=item_out+parseInt($(this).val());
            }
        });
        $(this).find(".item_income").html(item_income);
        $(this).find(".item_income_input").val(item_income);
        $(this).find(".item_out").html(item_out);
        $(this).find(".item_out_input").val(item_out);
        total_income=total_income+item_income;
        total_out=total_out+item_out;
    });
    total_left=total_income-total_out;
	if(class_name=='.history_table'){
		$("#totalsr").html(total_income);
	    $("#totalkz").html(total_out);
	    $("#totalyk").html(total_left);
	}
	if(class_name=='.plan_table'){
		$("#totalsr_plan").html(total_income);
	    $("#totalkz_plan").html(total_out);
	    $("#totalyk_plan").html(total_left);
	}
    
 }

 // 检测money,输入的非正规数字时归零处理 
function formatMoney(s,type) {
    var zf = 0;
    if(s<0) {
        zf = 1;
        s = 0;
    }
    if (/[^0-9\.]/.test(s)) return "0";
    if (s == null || s == "") return "0";
    // s = s.toString().replace(/^(\d*)$/, "$1.");
    // s = (s + "00").replace(/(\d*\.\d\d)\d*/, "$1");
    // s = s.replace(".", ",");
    var re = /(\d)(\d{3},)/;
    while (re.test(s))
    s = s.replace(re, "$1,$2");
    s = s.replace(/,(\d\d)$/, ".$1");
    if (type == 0) {
        var a = s.split(".");
        if (a[1] == "00") {
            s = a[0];
        }
    }
    if(zf==1) {
        s = "-"+s;
    }
    return s;
}