var Curatr = function(args) {

  // Default options
  this.defaults = {};

  // Merge defaults with instance arguments
  this.opts = $.extend(false,{},this.defaults,args);

  // Get started...
  this.init = function() {

  }
  
  this.helpers = {
    
    halt : function(ev) {
      ev.preventDefault();
      ev.stopPropagation();
    },
      
    url_regex : function() {
      return /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/m
    }
     
  }
  
  return this;

}