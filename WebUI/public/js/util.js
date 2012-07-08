
var message = new function(){
    var self = this;

    this.dom = function(){
        return self.__dom || (self.__dom = $('#alert'));
    };

    var sid = null;
    this.show = function(msg, time){
        clearTimeout(sid);
        self.dom().html(msg||'').show();
        sid = setTimeout(self.hide, time||7000);
    };

    this.hide = function(){
        self.dom().hide();
    };
}();
