$(function(){
    $('input[name=hide]').change(function(dom){
        var visible = dom.target.checked ? false : true;
        $.ajax({
            url: app_root+'/api/status/'+status_id+'/visible.json',
            type: 'POST',
            dataType: 'json',
            data: {visible: visible},
            success: function(data, type){
                message.show(data.visible ? '表示にしました' : '非表示にしました');
            },
            error: function(xhr, stat, err){
                alert('error');
            },
            complete: function(xhr, stat){}
        });
    });
});
